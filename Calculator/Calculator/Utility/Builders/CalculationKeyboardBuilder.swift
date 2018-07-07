//
//  CalculatorKeyboardBuilder.swift
//  Calculator
//
//  Created by ryoku on 2018/07/08.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

struct CalculationKeyboardBuilder {
    
    static func build() ->CalculationKeyboard {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height / 2)
        let vm = CalculationKeyboardViewModelImpl()
       let view = CalculationKeyboard(frame: frame, viewModel: vm)
        return view
    }
    
}

