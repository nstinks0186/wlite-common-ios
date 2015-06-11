//
//  CUserRouter.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import Alamofire

public enum CUserRouter: URLRequestConvertible {
    static var OAuthToken: String?
    
    case ReadUser()
    
    var method: Alamofire.Method {
        switch self {
        case .ReadUser:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .ReadUser(let username):
            return "/user"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: CConstants.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = CUserRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        default:
            return mutableURLRequest
        }
    }
}