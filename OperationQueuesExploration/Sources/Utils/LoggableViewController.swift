//
//  LoggableViewController.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 12/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class LoggableViewController: UIViewController {
	@IBOutlet private weak var logTextView: UITextView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		logTextView.text = ""
		logTextView.isEditable = false
	}
}

extension LoggableViewController {
	private var currentDateString: String {
		let date = Date()
		let formatter = DateFormatter()
		
		formatter.dateStyle = .short
		formatter.timeStyle = .medium
		
		return formatter.string(from: date)
	}

	enum LogType {
		case infos
		case warning
		case error
		case good
		
		func getColor() -> UIColor {
			var color = UIColor.black
			
			switch self {
			case .warning:
				color = UIColor.orange
			case .error:
				color = UIColor.red
			case .good:
				color = UIColor.green
				
			default:
				color = UIColor.black
			}
			
			return color
		}
	}

	func log(_ message: String, type: LogType = .infos) -> Void {
		let attributes: [NSAttributedStringKey: Any] = [
			.foregroundColor: type.getColor()
		]
		
		let attributedStr = NSMutableAttributedString(string: "[\(currentDateString)]: \(message)\n", attributes: attributes)

		DispatchQueue.main.sync { [weak self] in
			let logText = self?.logTextView.attributedText.mutableCopy() as! NSMutableAttributedString
			
			logText.append(attributedStr)
			self?.logTextView.attributedText = logText
		}
	}
}
