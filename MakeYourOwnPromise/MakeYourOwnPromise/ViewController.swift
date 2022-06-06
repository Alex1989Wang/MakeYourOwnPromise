//
//  ViewController.swift
//  MakeYourOwnPromise
//
//  Created by jiangwang on 2022/6/6.
//

import UIKit

class ViewController: UIViewController {
    
    var promise: Promise<Bool>?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func didClickTestPromiseButton() {
        
        testPromise()
    }
}

extension ViewController {
    
    func testPromise() {
        
        let promise = Promise<Bool> { [weak self] ret in
            self?.someAsynchronousFunctionResultInRandomBool(completed: { result in
                ret.fulfills(with: result)
            })
        }
        self.promise = promise
        
        promise.then({ [weak self] _ in
            (self?.asyncStringFunctionInPromise())!
        }).done({ string in
            print(string)
        })
    }
    
    enum TestError: Error {
        case general
    }
    
    func someAsynchronousFunctionResultInRandomBool(seconds: Int = 1, completed completion: @escaping (Bool)->Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(seconds)) {
            let random = Int.random(in: 0..<100000).remainderReportingOverflow(dividingBy: 2).partialValue == 0
            completion(random)
        }
    }
    
    func asyncStringFunctionInPromise() -> Promise<String> {
        let promise = Promise<String>({ ret in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                ret.fulfills(with: "Hello World.")
            }
        })
        return promise
    }
}
