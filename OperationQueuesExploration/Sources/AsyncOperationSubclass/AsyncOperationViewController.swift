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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		DispatchQueue.global().async { [weak self] in
			self?.beginOperations()
		}
    }

	func beginOperations() -> Void {
		log("Starting operations")
		
		let operation = TimerOperation(withDelay: 5)
		operation.completionBlock = { [weak self] in
			self?.log("Operation terminated")
		}
		
		queue.addOperation(operation)
	}
}
