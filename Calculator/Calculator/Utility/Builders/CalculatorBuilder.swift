//
//  CalculatorBuilder.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBuilder {
    
    static func build() ->UIViewController {
        
        let vc = R.storyboard.calculator.instantiateInitialViewController()
        let vm = CalculatorViewModelImpl(
            calculator: CalculatorImpl()
        )
        vc?.inject(viewModel: vm)

        return vc!
    }
    
}
