//
//  CRequestTests.swift
//  Common
//
//  Created by Pinuno Fuentes on 6/11/15.
//  Copyright (c) 2015 Wunderlite. All rights reserved.
//

import XCTest
import Common

class CRequestTests: XCTestCase {
    
    var request = Common.CRequest(endpoint: "")

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitEndpoint() {
        
        ////////////////////////
        //        .User
        ////////////////////////
        
        request = CRequest(endpoint: "User.FetchLoggedInUser")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/user", "")
        
        request = CRequest(endpoint: "User.FetchUsersForUser")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/users", "")
        
        ////////////////////////
        //        .Folder
        ////////////////////////
        
        request = CRequest(endpoint: "Folder.FetchFoldersForUser")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folders", "")
        
        request = CRequest(endpoint: "Folder.FetchFolder")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folders/:id", "")
        
        request = CRequest(endpoint: "Folder.CreateFolder")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "POST", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folders", "")
        
        request = CRequest(endpoint: "Folder.UpdateFolder")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "PATCH", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folders/:id", "")
        
        request = CRequest(endpoint: "Folder.DeleteFolder")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "DELETE", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folders/:id", "")
        
        request = CRequest(endpoint: "Folder.GetFolderRevision")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/folder_revisions", "")
        
        ////////////////////////
        //        .List
        ////////////////////////
        
        request = CRequest(endpoint: "List.FetchListsForUser")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists", "")
        
        request = CRequest(endpoint: "List.FetchList")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists/:id", "")
        
        request = CRequest(endpoint: "List.CreateList")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "POST", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists", "")
        
        request = CRequest(endpoint: "List.UpdateList")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "PATCH", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists/:id", "")
        
        request = CRequest(endpoint: "List.MakeListPublic")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "PATCH", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists/:id", "")
        
        request = CRequest(endpoint: "List.DeleteList")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "DELETE", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/lists/:id", "")
        
        
        ////////////////////////
        //        .Task
        ////////////////////////
        
        request = CRequest(endpoint: "Task.FetchTasksForList")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/tasks", "")
        
        request = CRequest(endpoint: "Task.FetchTask")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "GET", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/tasks/:id", "")
        
        request = CRequest(endpoint: "Task.CreateTask")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "POST", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/tasks", "")
        
        request = CRequest(endpoint: "Task.UpdateTask")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "PATCH", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/tasks/:id", "")
        
        request = CRequest(endpoint: "Task.DeleteTask")
        XCTAssertNotNil(request, "")
        XCTAssertEqual(request.method, "DELETE", "")
        XCTAssertEqual(request.url, "a.wunderlist.com/api/v1/tasks/:id", "")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
