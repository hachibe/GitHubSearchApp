//
//  SearchViewModelTests.swift
//  GitHubSearchAppTests
//
//  Created by 坪内 征悟 on 2017/06/21.
//  Copyright © 2017年 Masanori. All rights reserved.
//

import XCTest
import OHHTTPStubs

class SearchViewModelTests: XCTestCase {
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func testExample() {
        stub(condition: isHost("mywebservice.com")) { _ in
            let obj = ["key1": "value1", "key2": ["value2A", "value2B"]] as [String : Any]
            return OHHTTPStubsResponse(jsonObject: obj, statusCode: 200, headers: nil)
        }
    }
}
