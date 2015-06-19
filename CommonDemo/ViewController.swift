//
//  ViewController.swift
//  CommonDemo
//
//  Created by Pinuno Fuentes on 6/10/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import UIKit
import Common
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        func doPostAuth(token: String) {
            println("access token: " + token)
            App.accessToken = token
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.clientID,
                "X-Access-Token":App.accessToken!
            ]
        }
        
        if let token = Wlite.accessToken {
            doPostAuth(token)
        }else {
            Wlite.authorizeWithCallbackURL(App.callbackURL, successHandler: { (token) -> Void in
                doPostAuth(token)
                }, failureHandler: { (error) -> Void in
                    println("authorization failed: \(error)")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

