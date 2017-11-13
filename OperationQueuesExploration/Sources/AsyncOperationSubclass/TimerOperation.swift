//
//  TimerOperation.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 12/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class TimerOperation: Operation {
	private var timer: Timer? = nil
	private let delay: TimeInterval

	private enum State: String {
		case ready
		case canceled
		case finished
		case executing

		func keyPath() -> String {
			return "is\(self.rawValue.capitalized)"
		}
	}
	
	private var state: State = .ready {
		willSet {
			willChangeValue(forKey: newValue.keyPath())
			willChangeValue(forKey: state.keyPath())
		}
		didSet {
			didChangeValue(forKey: state.keyPath())
			didChangeValue(forKey: oldValue.keyPath())
		}
	}
	
	override var isFinished: Bool { return state == .finished }
	override var isCancelled: Bool { return state == .canceled }
	override var isExecuting: Bool { return state == .executing }

	override var isReady: Bool {
		let dependenciesFinished = dependencies.reduce(true) { return $0 && $1.isFinished }
		
		return state == .ready && dependenciesFinished
	}

	required init(withDelay delay: TimeInterval) {
		self.delay = delay

		super.init()
	}
	
	override func start() {
		guard isCancelled == false,
			isFinished == false else {
			state = .finished
			return
		}
		
		DispatchQueue.main.async { [weak self] in
			guard let wSelf = self else {
				return
			}
			
			wSelf.state = .executing
			
			wSelf.timer = Timer.scheduledTimer(withTimeInterval: wSelf.delay, repeats: false, block: { [weak self] (timer) in
				timer.invalidate()
				self?.state = .finished
			})
		}
	}
	
	override func cancel() {
		timer?.invalidate()
		state = .canceled
	}
}
