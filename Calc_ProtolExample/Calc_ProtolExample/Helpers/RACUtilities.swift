//
//  RACUtilities.swift
//  Calc_ProtolExample
//
//  Created by mc373 on 07.06.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

//func textSignal(textField: UITextField) -> SignalProducer<String, NoError> {
//    return textField.rac_textSignal().toSignalProducer()
//    |> map { $0! as! String }
//    |> catch {_ in SignalProducer(value: "") }
//}

//extension UIButton {
//    public var rac_enabled: MutableProperty<Bool> {
//        return lazyMutableProperty(self, key: &AssociationKey.text, setter: { self.enabled = $0 }, getter: { self.enabled })
//    }
//}