//
//  PromiseCounter.swift
//  MakeYourOwnPromise
//
//  Created by jiangwang on 2022/6/6.
//

import Foundation

struct PromiseCounter {
    
    static private var count = 0
    
    static func reset() {
        count = 0
    }
    
    static func increment() {
        count += 1
    }
    
    static func getCount() -> Int {
        return count
    }
}
