//
//  Firstly.swift
//  Demo
//
//  Created by jiangwang on 2022/6/2.
//

import Foundation

/*
 1. init a promise with an empty box
 
 2. try execute whatever suplied by `firstly`'s closure
 
 3. get the closure's returned promise and connect its boxed handler with the local promise's seal function
 
 4. return the local promise
 */
public func firstly<T, U: Promise<T>>(_ execute: () throws -> U) -> U {
    let promise = U()
    do {
        let rv = try execute()
        rv.pipe(to: promise.box.seal)
    } catch let err {
        promise.box.seal(.failed(err))
    }
    return promise
}
