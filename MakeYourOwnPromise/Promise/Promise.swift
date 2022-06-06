//
//  Promise.swift
//  Demo
//
//  Created by jiangwang on 2022/6/2.
//

import Foundation
import UIKit

/// This represents a asynchronous function call
/// Questions:
/// 1. could it be synchronous?
///

final public class Promise<Value> {
    
    /// the result this promise yields
    let box: EmptyBox<Result<Value>>
    
    init(_ execute: @escaping (Resolver<Value>) -> Void) {
        box = EmptyBox()
        let resolver = Resolver(box: box)
        execute(resolver)
    }
    
    init() {
        box = EmptyBox()
    }
    
}

/// the generic result of a promise
enum Result<Value> {
    case fulfilled(Value)
    case failed(Error)
}

enum PromiseError: Error {
    case general // represents a general error
}

final class EmptyBox<T> {
    
    enum Boxed {
        case pending((T)->Void)
        case resolved(T)
    }
    
    private var boxed: Boxed = .pending( {_ in } )
    
    func inspect() -> Boxed {
        return boxed
    }
    
    func inspect(_ execute: (inout Boxed) -> Void) {
        execute(&boxed)
    }
    
    func seal(_ value: T) {
        // the box has been sealed
        guard case let .pending(handler) = boxed else {
            return
        }
        handler(value)
        boxed = .resolved(value)
    }
}

final class Resolver<T> {
    
    let box: EmptyBox<Result<T>>
    
    init(box: EmptyBox<Result<T>>) {
        self.box = box
    }
    
    func fulfills(with value: T) {
        box.seal(.fulfilled(value))
    }
    
    func fails(with error: Error) {
        box.seal(.failed(error))
    }
}