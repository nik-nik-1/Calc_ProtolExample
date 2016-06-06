//
//  ViewModelCalcBrain.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 06.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation
import ReactiveCocoa

class ViewModelCalcBrain {
    
    private(set) var valuesOnCoreboard = MutableProperty<String>("")
    private(set) var lastUsedOperation = MutableProperty<String>("")

    private var userIsInTheMiddeOfTyping = false
    
}
