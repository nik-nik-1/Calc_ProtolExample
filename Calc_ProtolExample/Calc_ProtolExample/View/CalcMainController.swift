//
//  CalcMainController.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 02.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import ReactiveCocoa

enum typeOfButtonClick {
    case number
    case operation
    
    case numberButton (String)      //0
    case operationButton (String)   //1
}


//MARK: Native function of the View
class CalcMainController: UIViewController
    //, displayOfCalcProtocol
{
    
    @IBOutlet weak var scoreboardLable: UILabel!
    @IBOutlet weak var operationButton: UIButton! //not Used yet!
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var operationButtonCollection: [UIButton]!
    
    //    private var userIsInTheMiddeOfTyping = false
    private var calcViewModel = ViewModelCalcBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bindSignals()
    }
    
    
    func bindSignals() {
        numberButtonCollection.bindAllProperty(&calcViewModel, type: typeOfButtonClick.number)
        operationButtonCollection.bindAllProperty(&calcViewModel, type: typeOfButtonClick.operation)
        
        scoreboardLable.rac_text <~ calcViewModel.valuesOnScoreboard
        //
        //        let buttonAction = CocoaAction(calcViewModel.buttonAction, input: ())
        //        operationButton.addTarget(buttonAction, action: CocoaAction.selector, forControlEvents: UIControlEvents.TouchUpInside)
        //
        //        calcViewModel.buttonAction.events.observeNext { event in
        //            switch event {
        //            case let .Next(value): print ("NextEvent, value: \(value)")// A Next event from the inner producer
        //            case .Completed: print ("Completed") // A Completed event from the inner producer
        //            default: break
        //            }
    }
    
    //        viewModel.text <~ textSignal(txtField)
    //        buttonEnabled <~ viewModel.validatedTextProducer
    //
    //        cocoaAction = CocoaAction(viewModel.action, input:"Actually I don't need any input.")
    //        button.addTarget(cocoaAction, action: CocoaAction.selector, forControlEvents: UIControlEvents.TouchDown)
    //
    //        viewModel.action.values.observe(next: {value in
    //            println("view model action result \(value)")
    //
    //        //        textField.rac_textSignal().subscribeNextAs {
    //        //            (string: String) in
    //        //            self.label.text = string
    //        //        }
    //
    //        self.numberButton.rac_signalForControlEvents(.TouchUpInside)
    //            .subscribeNext { _ in
    //                print("numberButton")
    //        }
    //        self.operationButton.rac_signalForControlEvents(.TouchUpInside)
    //            .subscribeNext { _ in
    //                print("operationButton")
    //        }
    
    // calcViewModel.valuesOnScoreboardtext <~ textSignal(scoreboardLable.text)
    
    //        }
    
    
    
    
    @IBAction func numberButtonClicked(sender: UIButton) {
        
        //self.generateCalcDisplayText(typeOfButtonClick.numberButton(sender.restorationIdentifier!))
        
    }
    
    @IBAction func operationButtonClicked(sender: UIButton) {
        
        //self.generateCalcDisplayText(typeOfButtonClick.operationButton(sender.restorationIdentifier!))
    }
    
}


//MARK: extension UIButton
private extension Array where Element: UIButton {
    func bindAllProperty(inout vc:ViewModelCalcBrain, type: typeOfButtonClick){
        for itemButton in self {
            
            switch type {
            case .number: itemButton.bindProperty(&vc, inputDigit: typeOfButtonClick.numberButton(itemButton.restorationIdentifier!))
                
            case .operation: itemButton.bindProperty(&vc, inputDigit: typeOfButtonClick.operationButton(itemButton.restorationIdentifier!))
            default:
                print("Error to bind key!!!")
            }
            
        }
    }
}

private extension UIButton {
    func bindProperty(inout vc:ViewModelCalcBrain, inputDigit:typeOfButtonClick) -> () {
        self.rac_signalForControlEvents(.TouchUpInside)
            .subscribeNext { value in
                
                print("numberButton \(value.restorationIdentifier)")
                
                vc.generateCalcDisplayText (inputDigit)
        }
    }
}


////MARK: Using Class for display value
//protocol displayOfCalcProtocol {
//    func generateCalcDisplayText (inputDigit:typeOfButtonClick)
//    func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String
//    func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String
//}
//
//extension displayOfCalcProtocol where Self: CalcMainController {
//
//    func generateCalcDisplayText (inputDigit:typeOfButtonClick) {
//
//        switch inputDigit {
//        case .numberButton(let value):
//            scoreboardLable.text = generateCalcDisplayTextForNumberPressed (value)
//            break
//        case .operationButton(let value):
//            scoreboardLable.text = generateCalcDisplayTextForOperationPressed (value)
//            break
//        }
//    }
//
//    func generateCalcDisplayTextForNumberPressed (inputDigit:String) -> String{
//        var scoreboardLableText:String = ""
//
//        if calcViewModel.userIsInTheMiddeOfTyping {
//            let texCurrentInDysplay = scoreboardLable.text!
//            scoreboardLableText = texCurrentInDysplay + inputDigit
//        } else {
//            scoreboardLableText = inputDigit
//        }
//        calcViewModel.userIsInTheMiddeOfTyping = true
//
//        return scoreboardLableText
//    }
//
//    func generateCalcDisplayTextForOperationPressed (mathematicSymbol:String) -> String{
//        var scoreboardLableText:String = ""
//
//        calcViewModel.userIsInTheMiddeOfTyping = false
//
//        if let inputText = scoreboardLable.text {
//            let resultOfCalculation = calcViewModel.calcBrain.calculateValueForView(inputText, symbolWhatCalculate: mathematicSymbol)
//            
//            scoreboardLableText = String(resultOfCalculation)
//        }
//        return scoreboardLableText
//    }
//}
