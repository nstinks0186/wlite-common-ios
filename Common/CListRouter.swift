//
//  CListRouter.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation
import Alamofire

public enum CListRouter: URLRequestConvertible {
    static var OAuthToken: String?
    
    case ReadLists()
    case CreateList([String: AnyObject])
    case ReadList(String)
    case UpdateList(String)
    case DeleteList(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadLists:
            return .GET
        case .CreateList:
            return .POST
        case .ReadList:
            return .GET
        case .UpdateList:
            return .PATCH
        case .DeleteList:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .ReadLists():
            return "/lists"
        case .CreateList:
            return "/lists"
        case .ReadList(let listid):
            return "/lists/\(listid)"
        case .UpdateList(let listid):
            return "/lists/\(listid)"
        case .DeleteList(let listid):
            return "/lists/\(listid)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: CConstants.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = CListRouter.OAuthToken {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .CreateList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}