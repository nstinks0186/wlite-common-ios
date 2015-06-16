//
//  CTaskRouter.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import Alamofire

public enum CTaskRouter: URLRequestConvertible {
    static var OAuthToken: String?
    
    case ReadTasks()
    case CreateTask([String: AnyObject])
    case ReadTask(String)
    case UpdateTask(String)
    case DeleteTask(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadTasks:
            return .GET
        case .CreateTask:
            return .POST
        case .ReadTask:
            return .GET
        case .UpdateTask:
            return .PATCH
        case .DeleteTask:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadTasks():
            return "/tasks"
        case .CreateTask:
            return "/tasks"
        case .ReadTask(let taskid):
            return "/tasks/\(taskid)"
        case .UpdateTask(let taskid):
            return "/tasks/\(taskid)"
        case .DeleteTask(let taskid):
            return "/tasks/\(taskid)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: CConstants.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = CTaskRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .CreateTask(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}