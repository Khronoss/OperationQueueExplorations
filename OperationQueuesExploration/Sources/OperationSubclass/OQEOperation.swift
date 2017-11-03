//
//  OQEOperation.swift
//  OperationQueuesExploration
//
//  Created by Anthony Merle on 03/11/2017.
//  Copyright © 2017 Anthony Merle. All rights reserved.
//

import UIKit

class OQEOperation: Operation {
    var result = 0
    private var maxValue: Int
    
    required init(_ maxValue: Int) {
        self.maxValue = maxValue
        
        super.init()
    }

    override func main() {
        for i in 1...maxValue {
            result += i
        }
    }
}
