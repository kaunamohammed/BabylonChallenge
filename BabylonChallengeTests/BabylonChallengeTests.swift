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
    func test_mock_api_request() {
        let successExpectation = expectation(description: "Successfully made Network Request")

        let router: NetworkRouter = MockAPIRequest()
        router.request(endPoint: EndPoint()) { (result) in
            switch result {
            case .success(_):
                successExpectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

}

class MockAPIRequest: NetworkRouter {
    func request(endPoint: EndPoint, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        delay(seconds: 1) {
            completion(.success(.init()))
        }
    }
    func cancel() {
    }
}
