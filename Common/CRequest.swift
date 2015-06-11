//
//  CRequest.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import Foundation

public class CRequest {
    public var method: String = ""
    public var url: String = ""
    
    public init(endpoint:String) {
        switch endpoint {
            // User
        case "User.FetchLoggedInUser" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/user"
        case "User.FetchUsersForUser" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/users"
            
            // Folder
        case "Folder.FetchFoldersForUser" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/folders"
        case "Folder.FetchFolder" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/folders/:id"
        case "Folder.CreateFolder" :
            method = "POST"
            url = "a.wunderlist.com/api/v1/folders"
        case "Folder.UpdateFolder" :
            method = "PATCH"
            url = "a.wunderlist.com/api/v1/folders/:id"
        case "Folder.DeleteFolder" :
            method = "DELETE"
            url = "a.wunderlist.com/api/v1/folders/:id"
        case "Folder.GetFolderRevision" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/folder_revisions"
            
            // List
        case "List.FetchListsForUser" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/lists"
        case "List.FetchList" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/lists/:id"
        case "List.CreateList" :
            method = "POST"
            url = "a.wunderlist.com/api/v1/lists"
        case "List.UpdateList" :
            method = "PATCH"
            url = "a.wunderlist.com/api/v1/lists/:id"
        case "List.MakeListPublic" :
            method = "PATCH"
            url = "a.wunderlist.com/api/v1/lists/:id"
        case "List.DeleteList" :
            method = "DELETE"
            url = "a.wunderlist.com/api/v1/lists/:id"
            
            // Task
        case "Task.FetchTasksForList" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/tasks"
        case "Task.FetchTask" :
            method = "GET"
            url = "a.wunderlist.com/api/v1/tasks/:id"
        case "Task.CreateTask" :
            method = "POST"
            url = "a.wunderlist.com/api/v1/tasks"
        case "Task.UpdateTask" :
            method = "PATCH"
            url = "a.wunderlist.com/api/v1/tasks/:id"
        case "Task.DeleteTask" :
            method = "DELETE"
            url = "a.wunderlist.com/api/v1/tasks/:id"
            
        default :
            method = ""
            url = ""
        }
    }
    
}