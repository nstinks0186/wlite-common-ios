//
//  Wlite.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

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

public typealias WliteAuthorizeSuccessHandler = (token: String) -> Void
public typealias WliteAuthorizeFailureHandler = (error: NSError) -> Void

public class Wlite {
    static var consumerKey = "";
    static var consumerSecret = "";
    
    static var successHandler : WliteAuthorizeSuccessHandler?;
    static var failureHandler : WliteAuthorizeFailureHandler?;
    
    public class func setupClientID(id: String, clientSecret secret: String) {
        consumerKey = id;
        consumerSecret = secret;
    }
    
    public class func authorizeWithCallbackURL(callbackURL:String, successHandler: WliteAuthorizeSuccessHandler, failureHandler: WliteAuthorizeFailureHandler){
        Wlite.successHandler = successHandler
        Wlite.failureHandler = failureHandler
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let token = userDefaults.stringForKey("com.wlite.oauth.accessToken") {
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": consumerKey,
                "X-Access-Token":token
            ]
            
            successHandler(token: token)
        }
        else {
            let oauthswift = OAuth2Swift(consumerKey: consumerKey,
                consumerSecret: consumerSecret,
                authorizeUrl: "https://www.wunderlist.com/oauth/authorize",
                accessTokenUrl: "https://www.wunderlist.com/oauth/access_token",
                responseType: "token")
            oauthswift.authorizeWithCallbackURL( NSURL(string: callbackURL)!,
                scope: "",
                state: "com.wlite.oauth.state",
                success: {
                    credential, response, parameters in
                    // this is actually useless
                    println("success: \(credential) ; \(response) ; \(parameters)")
                },
                failure: {
                    (error:NSError!) -> Void in
                    // this is actually useless
                    println(error.localizedDescription)
            })
        }
    }
    
    public class func handleOpenURL(url: NSURL) {
        if (url.host == "wlite") {
            let queryItem = url.queryItemForKey("token")
            if let token = queryItem!.value{
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(token, forKey: "com.wlite.oauth.accessToken")
                Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                    "X-Client-ID": consumerKey,
                    "X-Access-Token":token
                ]
                
                if let handler = successHandler {
                    handler(token: token)
                }
            }
            else {
                if let handler = failureHandler {
                    // improve this shit
                    handler(error: NSError())
                }
            }
        }
    }
    
}
