//
//  AsyncOperationViewController.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 12/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class AsyncOperationViewController: LoggableViewController {
	private let queue = OperationQueue()
	private let delays: [TimeInterval] = [5, 15, 10, 13, 4, 5]
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func launchNoDepMethod() {
		DispatchQueue.global().async { [weak self] in
			self?.beginNoDependencyOperations()
		}
	}

	@IBAction func launchDependentMethod() {
		DispatchQueue.global().async { [weak self] in
			self?.beginDependentOperations()
		}
	}

	func beginNoDependencyOperations() -> Void {
		log("Starting operations with no dependencies")
		
		let maxDelay = delays.reduce(0) { return max($0, $1) }
		log("Waiting time should take \(maxDelay) seconds", type: .warning)

		var operations: [Operation] = []
		
		for delay in delays {
			let operation = TimerOperation(withDelay: delay)
			operation.completionBlock = { [weak self] in
				self?.log("Operation terminated")
			}
			operations.append(operation)
		}
		
		queue.addOperations(operations, waitUntilFinished: true)
		
		log("No dependencies operations finished !", type: .good)
	}
	
	private func beginDependentOperations() -> Void {
		log("Starting operations with dependency to each others")
		
		let totalDelay = 10
		log("Waiting time should take \(totalDelay) seconds", type: .warning)

		var operations: [Operation] = []

		let firstOp = TimerOperation(withDelay: 3)
		firstOp.completionBlock = { [weak self] in
			self?.log("First operation terminated")
		}
		operations.append(firstOp)

		let secondOp = TimerOperation(withDelay: 7)
		secondOp.completionBlock = { [weak self] in
			self?.log("First operation terminated")
		}
		secondOp.addDependency(firstOp)
		operations.append(secondOp)
		
		queue.addOperations(operations, waitUntilFinished: true)

		log("Dependent operations finished !", type: .good)
	}
}
