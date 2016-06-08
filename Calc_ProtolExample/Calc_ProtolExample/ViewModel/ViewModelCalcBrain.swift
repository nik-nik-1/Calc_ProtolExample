//
//  ViewModelCalcBrain.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 06.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

struct ViewModelCalcBrain {
    
    private(set) var valuesOnScoreboard = MutableProperty<String>("0")
    private(set) var lastUsedOperation = MutableProperty<String>("")
    
    var userIsInTheMiddeOfTyping = false
    
    var calcBrain = CalcBrain()
    
    //    var buttonAction = Action<Bool, Void, NoError>() { value in
    //        return SignalProducer<Void, NoError> { observer, _ in
    //            //dataProvider.addNewTestProduct()
    //
    //            observer.sendNext()
    //            observer.sendCompleted()
    //    }}
    //
    //    var cocoabuttonAction: CocoaAction!
    //
    //        init() {
    //
    //                cocoabuttonAction = CocoaAction(buttonAction)
    //        }
    
    //    var numberButtonClickedAction: Action<Void, String, NoError>!
    //    var cocoaNumberButtonClickedAction: CocoaAction!
    
    
    //
    //    init() {
    //        numberButtonClickedAction = Action(enabledIf: true) { (_: Void) in
    //            return combineLatest(self.valuesOnScoreboard.producer)
    //        }
    //
    //        numberButtonClickedAction.values.observe { (valuesOnScoreboard) in
    //            print("\(valuesOnScoreboard)")
    //        }
    //    }
    //numberButtonClickedAction =
    //    cocoaNumberButtonClickedAction = CocoaAction(numberButtonClickedAction)
    
}

//MARK: Using Class for display value
//protocol displayOfCalcProtocol {
//    func generateCalcDisplayText (inputDigit:typeOfButtonClick)
////    func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String
////    func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String
//}

extension ViewModelCalcBrain {
    
    mutating func generateCalcDisplayText (inputDigit:typeOfButtonClick) {
        
        switch inputDigit {
        case .numberButton(let value):
            valuesOnScoreboard.value = generateCalcDisplayTextForNumberPressed (value)
            
        case .operationButton(let value):
            valuesOnScoreboard.value = generateCalcDisplayTextForOperationPressed (value)
        default:
            print ("Something wrong!!! See: {mutating func generateCalcDisplayText}")
        }
    }
    
    mutating func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String{
        var scoreboardLableText:String = ""
        
        if userIsInTheMiddeOfTyping {
            let texCurrentInDysplay = valuesOnScoreboard.value
            scoreboardLableText = texCurrentInDysplay + inputDigit
        } else {
            scoreboardLableText = inputDigit
        }
        userIsInTheMiddeOfTyping = true
        
        return scoreboardLableText
    }
    
    mutating func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String{
        var scoreboardLableText:String = ""
        
        userIsInTheMiddeOfTyping = false
        
        //if let inputText = valuesOnScoreboard.value {
        let inputText = valuesOnScoreboard.value
        let resultOfCalculation = calcBrain.calculateValueForView(inputText, symbolWhatCalculate: mathematicSymbol)
        
        scoreboardLableText = resultOfCalculation == 0 ? "0" : String(resultOfCalculation)
        //}
        return scoreboardLableText
    }
}
