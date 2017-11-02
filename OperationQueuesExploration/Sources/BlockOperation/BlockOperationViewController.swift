//
//  OperationBlockViewController.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 02/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class BlockOperationViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func calculate() {
        let queue = OperationQueue()
        
        let blockOperation = BlockOperation {
            var result = 0
            
            let mainQueue = OperationQueue.main
            
            for i in 1...1_000_000_000 {
                result += i
            }
            
            mainQueue.addOperation { [weak self] in
                self?.activity.stopAnimating()
                self?.resultLabel.text = "\(result)"
            }
        }
        
        queue.addOperation(blockOperation)
    }
    
    @IBAction func calcAsked() {
        resultLabel.text = "RESULT"
        activity.startAnimating()
        calculate()
    }
}
