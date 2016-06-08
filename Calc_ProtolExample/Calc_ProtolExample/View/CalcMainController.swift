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
class CalcMainController: UIViewController {
    
    @IBOutlet private weak var scoreboardLable: UILabel!
    @IBOutlet private weak var operationButton: UIButton! //not Used yet!
    @IBOutlet private weak var numberButton: UIButton!
    @IBOutlet private var numberButtonCollection: [UIButton]!
    @IBOutlet private var operationButtonCollection: [UIButton]!
    
    private static var calcViewModel = ViewModelCalcBrain()
    private var calcViewModel: ViewModelCalcBrain {
        get { return CalcMainController.calcViewModel }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindSignals()
    }
    
    
    private func bindSignals() {
        numberButtonCollection.bindAllProperty(typeOfButtonClick.number)
        operationButtonCollection.bindAllProperty(typeOfButtonClick.operation)
        
        scoreboardLable.rac_text <~ calcViewModel.valuesOnScoreboard
        
        
        //  operationButton.addTarget(calcViewModel.cocoabuttonAction, action: CocoaAction.selector, forControlEvents: UIControlEvents.TouchUpInside)
        //
        //                calcViewModel.buttonAction.events.observeNext { event in
        //                    switch event {
        //                    case let .Next(value): print ("NextEvent, value: \(value)")// A Next event from the inner producer
        //                    case .Completed: print ("Completed") // A Completed event from the inner producer
        //                    default: break
        //                    }
        //        }
    }
}


//MARK: extension UIButton
private extension Array where Element: UIButton {
    func bindAllProperty(type: typeOfButtonClick){
        for itemButton in self {
            
            let restorationIdentifier = itemButton.restorationIdentifier!
            
            switch type {
            case .number:
                itemButton.bindProperty(typeOfButtonClick.numberButton(restorationIdentifier))
            case .operation:
                itemButton.bindProperty(typeOfButtonClick.operationButton(restorationIdentifier))
            default:
                print("Error to bind a key!!!")
            }
        }
    }
}

private extension UIButton {
    func bindProperty(inputDigit:typeOfButtonClick) -> () {
        self.rac_signalForControlEvents(.TouchUpInside)
            .subscribeNext { value in
                
                print("buttonIdentifier: \(inputDigit)") //value.restorationIdentifier
                
                CalcMainController.calcViewModel.generateCalcDisplayText (inputDigit)
        }
    }
}


