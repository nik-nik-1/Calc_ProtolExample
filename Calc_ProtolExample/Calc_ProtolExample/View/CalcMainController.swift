//
//  CalcMainController.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 02.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

enum typeOfButtonClick {
    case operationButton (String)
    case numberButton (String)
}


//MARK: Native function of the View
class CalcMainController: UIViewController, displayOfCalcProtocol {
    
    @IBOutlet weak var scoreboardLable: UILabel!
    @IBOutlet weak var operationButton: UIButton! //not Used yet!
    
    private var userIsInTheMiddeOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    var calcBrainViewModel = CalcBrain()
    
    
    @IBAction func numberButtonClicked(sender: UIButton) {
        
        self.generateCalcDisplayText(typeOfButtonClick.numberButton(sender.restorationIdentifier!))
    }
    
    @IBAction func operationButtonClicked(sender: UIButton) {
        
        self.generateCalcDisplayText(typeOfButtonClick.operationButton(sender.restorationIdentifier!))
    }
    
}

//MARK: Using Class for display value
protocol displayOfCalcProtocol {
    func generateCalcDisplayText (inputDigit:typeOfButtonClick)
    func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String
    func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String
}

extension displayOfCalcProtocol where Self: CalcMainController {
    
    func generateCalcDisplayText (inputDigit:typeOfButtonClick) {
        
        switch inputDigit {
        case .numberButton(let value):
            scoreboardLable.text = generateCalcDisplayTextForNumberPressed (value)
            break
        case .operationButton(let value):
            scoreboardLable.text = generateCalcDisplayTextForOperationPressed (value)
            break
        }
    }
    
    func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String{
        var scoreboardLableText:String = ""
        
        if userIsInTheMiddeOfTyping {
            let texCurrentInDysplay = scoreboardLable.text!
            scoreboardLableText = texCurrentInDysplay + inputDigit
        } else {
            scoreboardLableText = inputDigit
        }
        userIsInTheMiddeOfTyping = true
        
        return scoreboardLableText
    }
    
    func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String{
        var scoreboardLableText:String = ""
        
        userIsInTheMiddeOfTyping = false
        
        if let inputText = scoreboardLable.text {
            let resultOfCalculation = calcBrainViewModel.calculateValueForView(inputText, symbolWhatCalculate: mathematicSymbol)
            
            scoreboardLableText = String(resultOfCalculation)
        }
        return scoreboardLableText
    }
}
