//
//  AppDelegate.swift
//  CommonDemo
//
//  Created by Pinuno Fuentes on 6/10/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Alamofire
import Common

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // this is the callback url that is registered in wunderlist
    // that callback url should redirect to <app url scheme>://wlite?access_token=<the token>
    let callbackURL = "https://dl.dropboxusercontent.com/u/33491043/sites/wlite/success.html"
    
    let clientID = "**"
    let clientSecret = "**"
    
    let completionHandler = {(request: NSURLRequest, response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?) -> Void in
        if (error != nil) {
            println("error: \(error)")
            println("response: \(response)")
        }
        if (JSON != nil) {
            println("result: \(JSON!)")
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Wlite.setupClientID(clientID, clientSecret: clientSecret)
        Wlite.authorizeWithCallbackURL(callbackURL, successHandler: { (token) -> Void in
            println("authorization successful: \(token)")
            
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": self.clientID,
                "X-Access-Token":token
            ]
            
//            self.readUser()
//            self.readFolders()
//            self.readFolderRevisions()
//            self.readFolder("946735")
//            self.readLists()
//            self.readList("86173208")
//            self.createTask("Test task, hola mundo!", forList: 164291775);
//            self.readTasks("86173208")
            
        }) { (error) -> Void in
            println("authorization failed: \(error)")
        };
        
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
        Wlite.handleOpenURL(url);
        return true
    }
    
    // MARK: User
    
    func readUser(){
        Alamofire
            .request(CUserRouter.ReadUser())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func readUsers() {
        // TODO: this
    }
    
    // MARK: Folder
    
    func readFolders(){
        Alamofire
            .request(CFolderRouter.ReadFolders())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func readFolderRevisions(){
        Alamofire
            .request(CFolderRouter.ReadFolderRevisions())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func createFolder() {
        // TODO: this
    }
    
    func readFolder(folderid: String) {
        Alamofire
            .request(CFolderRouter.ReadFolder(folderid))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func updateFolder() {
        // TODO: this
    }
    
    func deleteFolder() {
        // TODO: this
    }
    
    // MARK: List
    
    func readLists() {
        Alamofire
            .request(CListRouter.ReadLists())
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func createList(){
        // TODO: this
    }
    
    func readList(listid: String) {
        Alamofire
            .request(CListRouter.ReadList(listid))
            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func updateList(){
        // TODO: this
    }
    
    func deleteList(){
        // TODO: this
    }
    
    // MARK: Task
    
    func readTasks(listid: String) {
        // TODO: this
//        Alamofire
//            .request(CTaskRouter.ReadTasks())
//            .responseJSON(options: nil, completionHandler: completionHandler)
    }
    
    func createTask(title: String, forList listid:Int){
        let parameters : [ String : AnyObject] = [
            "title": title,
            "list_id": listid
        ]
        Alamofire
            .request(CTaskRouter.CreateTask(parameters))
            .responseJSON(options: nil, completionHandler: completionHandler)
        // TODO: this
    }
    
    func readTask(){
        // TODO: this
    }
    
    func updateTask(){
        // TODO: this
    }
    
    func deleteTask(){
        // TODO: this
    }
    
}

