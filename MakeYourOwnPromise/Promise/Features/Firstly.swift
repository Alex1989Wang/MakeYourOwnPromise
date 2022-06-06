//
//  Firstly.swift
//  Demo
//
//  Created by jiangwang on 2022/6/2.
//

import Foundation

/*
 We need to have some ways to wrap a function within a closure
 
 - Can't return Void: has to return something to wrap this execution and let the framework know
 the result of this execution
 */
public func firstly(_ execute: () -> Void) {
    execute()
}


public func then(_ execute: ()->Void) {
    execute()
}

