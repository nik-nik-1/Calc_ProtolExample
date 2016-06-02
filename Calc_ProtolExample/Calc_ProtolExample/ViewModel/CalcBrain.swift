//
//  CalcBrain.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 02.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation


struct CalcBrain {
    
    private init (){
        //CalcModel.calcModelInstance = self
    }
    
    //MARK: Calc Brain
    private var accumulator = 0.0
    
    mutating func setOperand (operand:Double){
        accumulator = operand
    }
    
    private enum Operation {
        case Constant (Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation ((Double, Double) -> Double)
        case Equals
    }
    
    private var operations : Dictionary <String, Operation> = [
        "ℏ" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "cos" : Operation.UnaryOperation(sqrt),
        "∗" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equals
    ]
    
    mutating func performOperation (symbol:String){
        if let operation = operations [symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation (let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private mutating func executePendingBinaryOperation() {
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending:PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction:(Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get {
            return accumulator
        }
    }
    
    
    
}