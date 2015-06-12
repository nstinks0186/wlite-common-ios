//
//  AppDelegate.swift
//  CommonDemo
//
//  Created by Pinuno Fuentes on 6/10/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire
import Common

extension NSURL {
    var allQueryItems: [NSURLQueryItem] {
        get {
            let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: false)!
            let allQueryItems = components.queryItems!
            return allQueryItems as! [NSURLQueryItem]
        }
    }
    
    func queryItemForKey(key: String) -> NSURLQueryItem? {
        
        let predicate = NSPredicate(format: "name=%@", key)
        return (allQueryItems as NSArray).filteredArrayUsingPredicate(predicate).first as? NSURLQueryItem
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let callbackURL = "https://dl.dropboxusercontent.com/u/33491043/sites/wlite/success.html"
    let consumerKey = "**"
    let consumerSecret = "**"
    let userID = "**"
    let folderList = ["**"]

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let token = userDefaults.stringForKey("access_token") {
           
            setupAuth(token)
            
//            readUser()
//            readFolders()
//            readFolderRevisions()
//            readFolder(folderList[0])
            
        } else {
            
            let oauthswift = OAuth2Swift(consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                authorizeUrl: "https://www.wunderlist.com/oauth/authorize",
                accessTokenUrl: "https://www.wunderlist.com/oauth/access_token",
                responseType: "token")
            oauthswift.authorizeWithCallbackURL( NSURL(string: callbackURL)!,
                scope: "user,repo",
                state: "",
                success: {
                    credential, response, parameters in
                    println("success: \(credential) ; \(response) ; \(parameters)")
                },
                failure: {
                    (error:NSError!) -> Void in
                    println(error.localizedDescription)
            })
        }
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        if (url.host == "oauth-callback") {
            if (url.path!.hasPrefix("/wunderlite")){
                OAuth2Swift.handleOpenURL(url)
            }
        }
        
        let queryItem = url.queryItemForKey("href")
        if let href = queryItem!.value{
            println("url: " + href)
            if let range = href.rangeOfString("#access_token="){
                let token = href.substringFromIndex(range.endIndex)
                NSUserDefaults.standardUserDefaults().setValue(token, forKey: "access_token")
                
                setupAuth(token)
            }
        }
        
        return true
    }
    
    // MARK: Convenience methods

    func setupAuth(token: String){
        println("token: " + token)
        
        var manager = Manager.sharedInstance
        manager.session.configuration.HTTPAdditionalHeaders = [
            "X-Client-ID":"71436ba1a9dc81c908f1",
            "X-Access-Token":token
        ]
    }
    
    func readUser(){
        Alamofire
            .request(CUserRouter.ReadUser())
            .responseJSON { (request, response, JSON, let error) in
                println("error: \(error)")
                println("result: \(JSON!)")
        }
    }
    
    func readFolders(){
        Alamofire
            .request(CFolderRouter.ReadFolders())
            .responseJSON { (request, response, JSON, let error) in
                println("error: \(error)")
                println("result: \(JSON!)")
        }
    }
    
    func readFolderRevisions(){
        Alamofire
            .request(CFolderRouter.ReadFolderRevisions())
            .responseJSON { (request, response, JSON, let error) in
                println("error: \(error)")
                println("result: \(JSON!)")
        }
    }
    
    func readFolder(folderid: String) {
        Alamofire
            .request(CFolderRouter.ReadFolder(folderid))
            .responseJSON { (request, response, JSON, let error) in
                println("error: \(error)")
                println("result: \(JSON!)")
        }
    }
    
    
}

