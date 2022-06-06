//
//  PromiseTests.swift
//  DemoTests
//
//  Created by jiangwang on 2022/6/2.
//

import XCTest
@testable import MakeYourOwnPromise

class PromiseTests: XCTestCase {

    var promise: Promise<Bool>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPromise() throws {
        promise = Promise<Bool> { [weak self] ret in
            self?.alwaysTrue()
        }
    }
    
    func testAsyncPromise() throws {
        let expectation = XCTestExpectation(description: "promise async execution")
        promise = Promise<Bool> { [weak self] ret in
            self?.someAsynchronousFunctionResultInRandomBool(completed: { result, error in
                defer {
                    expectation.fulfill()
                }
                if let err = error {
                    ret.fails(with: err)
                    guard case .resolved(.failed(_)) = ret.box.inspect() else {
                        XCTAssertTrue(false)
                        return
                    }
                    XCTAssertTrue(true) // Error could be of any kind, no way to compare at present
                    return
                }
                ret.fulfills(with: result)
                guard case let .resolved(.fulfilled(value)) = ret.box.inspect() else {
                    XCTAssertTrue(false)
                    return
                }
                XCTAssertEqual(value, result)
            })
        }
        wait(for: [expectation], timeout: 2)
    }
    
}


extension XCTestCase {
    func asyncStringFunctionInPromise() -> Promise<String> {
        let promise = Promise<String>({ ret in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                ret.fulfills(with: "Hello World.")
            }
        })
        return promise
    }
}
