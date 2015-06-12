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
    case ReadList(String)
    case UpdateList(String)
    case DeleteList(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ReadLists:
            return .GET
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
        case .ReadList(let listid):
            return "/list/\(listid)"
        case .UpdateList(let listid):
            return "/list/\(listid)"
        case .DeleteList(let listid):
            return "/list/\(listid)"
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
        default:
            return mutableURLRequest
        }
    }
}