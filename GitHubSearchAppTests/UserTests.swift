//
//  UserTests.swift
//  GitHubSearchAppTests
//
//  Created by Hachibe on 2017/03/04.
//  Copyright © 2017年 Masanori. All rights reserved.
//

import XCTest

class UserTests: XCTestCase {
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUser() {
        let jsonString = "{\"id\": 123,\"login\": \"test_login\"}"
        let json = try! JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: [])
        let user = try! User(json: json)
        XCTAssertEqual(user.id, 123)
        XCTAssertEqual(user.login, "test_login")
    }
}
