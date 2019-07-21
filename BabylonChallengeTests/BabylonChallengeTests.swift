//
//  BabylonChallengeTests.swift
//  BabylonChallengeTests
//
//  Created by Kauna Mohammed on 12/07/2019.
//  Copyright © 2019 Kauna Mohammed. All rights reserved.
//

import XCTest
@testable import BabylonChallenge

class BabylonChallengeTests: XCTestCase {

    func test_endpoint_properly_constructed() {

        let expectedEndpoint = URL(string: "https://jsonplaceholder.typicode.com/users?id=1")

        let endpoint = UsersEndPoint.user(by: 1).url
        XCTAssertTrue(endpoint == expectedEndpoint)

    }

    func test_only_capitalizing_first_characters() {

        let str = "what is dead may never die".capitalizeOnlyFirstCharacters()
        XCTAssertTrue(str == "What Is Dead May Never Die")

    }

}
