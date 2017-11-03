//
//  OperationSubclassViewController.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 03/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class OperationSubclassViewController: UIViewController {
    
    private let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        queue.qualityOfService = .default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startOperations() {
        let firstOP = OQEOperation(1_000_000)
        firstOP.completionBlock = {
            print("firstOP finished")
        }
        
        let secondOP = OQEOperation(10_000_000)
        secondOP.completionBlock = {
            print("secondOP finished")
        }

        let thirdOP = OQEOperation(100_000_000)
        thirdOP.completionBlock = {
            print("thirdOP finished")
        }
        
        queue.addOperation(firstOP)
        queue.addOperation(secondOP)
        queue.addOperation(thirdOP)
    }
}
