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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let endpoints = ["Avatar","File","File preview","Folder","List","Membership","Note","Positions","Reminder","Subtask","Task","Task comment","Upload","User","Webhooks"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // post-auth
        func doPostAuth(token: String) {
            // save access token
            println("access token: " + token)
            App.accessToken = token
            
            // setup session
            Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
                "X-Client-ID": App.clientID,
                "X-Access-Token":App.accessToken!
            ]
        }
        
        // authenticate
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
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return endpoints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("endpointCellIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text! = endpoints[indexPath.row]
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    

}

