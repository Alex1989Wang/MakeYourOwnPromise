//
//  DemoTests.swift
//  DemoTests
//
//  Created by jiangwang on 2022/5/26.
//

import XCTest
@testable import MakeYourOwnPromise

    
extension XCTestCase {
    func alwaysTrue() {
        XCTAssertTrue(true)
    }
}

class PromiseFeaturesTests: XCTestCase {
    func testFistlyFunction() throws {
        firstly {
            alwaysTrue()
        }
    }
}
