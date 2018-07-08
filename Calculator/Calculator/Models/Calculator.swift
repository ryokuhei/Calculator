//
//  Calculator.swift
//  Calculator
//
//  Created by ryoku on 2018/07/05.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation

protocol Calculator {
    func addition(_ lhs: Int, to rhs: Int) ->Int
    func subtraction(_ lhs: Int, from rhs: Int) ->Int
    func maltiplication(_ lhs: Int, by rhs: Int) ->Int
    func division(_ lhs: Int, by rhs: Int) ->Float
}

struct CalculatorImpl: Calculator {
    
    init() {
    }
    
    // 足し算
    func addition(_ lhs: Int, to rhs: Int) ->Int {
        return lhs + rhs
    }
    
    // 引き算
    func subtraction(_ lhs: Int, from rhs: Int) ->Int {
        return lhs - rhs
    }
    
    // 掛け算
    func maltiplication(_ lhs: Int, by rhs: Int) ->Int {
        return lhs * rhs
    }
    
    // わり算
    func division(_ lhs: Int, by rhs: Int) ->Float {
        return Float(lhs) / Float(rhs)
    }
}
