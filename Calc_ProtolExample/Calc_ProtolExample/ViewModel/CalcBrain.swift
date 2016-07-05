//
//  CalcBrain.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 02.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation

private enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> Double)
    case BinaryOperation((Double, Double) -> Double)
    case Equals
}

private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
}

//MARK: Calc Brain
struct CalcBrain {
    
    private var accumulator:Double = 0
    
    private func getDisplayValue (inputText: String) -> Double {
        return Double(inputText)!
    }
    
    private mutating func setOperand (inputText: String) {
        let operand = getDisplayValue(inputText)
        accumulator = operand
    }
    
    private var operations: Dictionary <String, Operation> = [
        "ℏ" :               Operation.Constant(M_PI), //"ℏ"
        "e" :               Operation.Constant(M_E), //"e"
        "operSrt" :         Operation.UnaryOperation(sqrt), //"sqrt"
        "operMultiply" :    Operation.BinaryOperation({$0 * $1}), //"∗"
        "operDivide" :      Operation.BinaryOperation({$0 / $1}), // "÷"
        "operMinus" :       Operation.BinaryOperation({$0 - $1}), // "-"
        "operPlus" :        Operation.BinaryOperation({$0 + $1}), // "+"
        "opereEqually" :    Operation.Equals, //"="
        "oper⊂" :           Operation.Constant(0) //"="
    ]
    
    private mutating func performOperation (symbol:String) {
        if let operation = operations [symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
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
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}

//MARK: func. for view
extension CalcBrain {
    
    mutating func calculateValueForView (inputText: String, symbolWhatCalculate: String) -> Double {
        
        setOperand(inputText)
        performOperation(symbolWhatCalculate)
        
        return self.result
    }
    
}