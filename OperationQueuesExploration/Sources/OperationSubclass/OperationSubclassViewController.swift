//
//  OperationSubclassViewController.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 03/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class OperationSubclassViewController: LoggableViewController {
    
    private let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        queue.qualityOfService = .default
		
		DispatchQueue.global().async { [weak self] in
			self?.startOperationsWithNoWait()
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startOperationsWithNoWait() {
		var operations: [Operation] = []
		let values: [Int] = [
			1_000_000,
			10_000_000,
			100_000_000,
			100_000_000
		]
		
		for value in values {
			let operation = OQEOperation(value)
			operation.completionBlock = { [weak self] in
				self?.log("operation for value \(value) finished, res: \(operation.result)")
			}
			operations.append(operation)
		}

		queue.addOperations(operations, waitUntilFinished: true)
		
		log("All calcul operations finished !", type: .good)
    }
}
