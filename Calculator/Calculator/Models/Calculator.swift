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
    
    func addition(_ lhs: Int, to rhs: Int) ->Int {
        return lhs + rhs
    }
    
    func subtraction(_ lhs: Int, from rhs: Int) ->Int {
        return lhs - rhs
    }
    
    func maltiplication(_ lhs: Int, by rhs: Int) ->Int {
        return lhs * rhs
    }
    
    func division(_ lhs: Int, by rhs: Int) ->Float {
        return Float(lhs) / Float(rhs)
    }
}
