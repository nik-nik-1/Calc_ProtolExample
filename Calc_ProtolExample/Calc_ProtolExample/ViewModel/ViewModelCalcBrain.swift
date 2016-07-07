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

	private var userIsInTheMiddeOfTyping = false
	private var calcBrain = CalcBrain()

	//        var buttonAction = Action<Bool, Void, NoError>() { value in
	//            return SignalProducer<Void, NoError> { observer, _ in
	//                //dataProvider.addNewTestProduct()
	//
	//                observer.sendNext()
	//                observer.sendCompleted()
	//        }}

	//        var cocoabuttonAction: CocoaAction!

	//            init() {
	//
	//                cocoabuttonAction = CocoaAction(buttonAction) { _ in
	//                    return true
	//                }
	//            }

}

//MARK: Using Class for display value

extension ViewModelCalcBrain {

	mutating func generateCalcDisplayText (inputDigit: TypeOfButtonClick) {

		switch inputDigit {
		case .numberButton(let value):
			valuesOnScoreboard.value = generateCalcDisplayTextForNumber (value)
		case .operationButton(let value):
			valuesOnScoreboard.value = generateCalcDisplayTextForOperation (value)
		default:
			print ("Something wrong!!! See: {mutating func generateCalcDisplayText}")
		}
	}

	private mutating func generateCalcDisplayTextForNumber (inputDigit: String) -> String {
		var scoreboardLableText: String = ""

		if userIsInTheMiddeOfTyping {
			let texCurrentInDysplay = valuesOnScoreboard.value
			scoreboardLableText = texCurrentInDysplay + inputDigit
		} else {
			scoreboardLableText = inputDigit
		}
		userIsInTheMiddeOfTyping = true

		return scoreboardLableText
	}

	private mutating func generateCalcDisplayTextForOperation (mathematicSymbol: String) -> String {
		var scoreboardLableText: String = ""

		userIsInTheMiddeOfTyping = false

		//if let inputText = valuesOnScoreboard.value {
		let inputText = valuesOnScoreboard.value
		let resultOfCalculation = calcBrain.calculateValueForView(inputText,
		                                                          symbolWhatCalculate: mathematicSymbol)

		scoreboardLableText = resultOfCalculation == 0 ? "0" : String(resultOfCalculation)
		//}
		return scoreboardLableText
	}

}
