//
//  DemoTests.swift
//  DemoTests
//
//  Created by jiangwang on 2022/5/26.
//

import XCTest
@testable import MakeYourOwnPromise

extension XCTestCase {
    
    enum TestError: Error {
        case general
    }
    
    func alwaysTrueAfter(seconds: Int, completed completion: @escaping (Bool)->Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(seconds)) {
            XCTAssertTrue(true)
            completion(true)
        }
    }
    
    func someAsynchronousFunctionResultInRandomBool(seconds: Int = 1, completed completion: @escaping (Bool, Error?)->Void) {
        let shouldGiveError = Int.random(in: 0..<100000).remainderReportingOverflow(dividingBy: 2).partialValue == 0
        if shouldGiveError {
            completion(false, TestError.general)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(seconds)) {
            let random = Int.random(in: 0..<100000).remainderReportingOverflow(dividingBy: 2).partialValue == 0
            completion(random, nil)
        }
    }
}

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
