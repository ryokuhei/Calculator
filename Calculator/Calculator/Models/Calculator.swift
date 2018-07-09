//
//  Calculator.swift
//  Calculator
//
//  Created by ryoku on 2018/07/05.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation

protocol Calculator {
    func addition(_ lhs: Int64, to rhs: Int64) ->Int64
    func subtraction(_ lhs: Int64, from rhs: Int64) ->Int64
    func maltiplication(_ lhs: Int64, by rhs: Int64) ->Int64
    func division(_ lhs: Int64, by rhs: Int64) ->Double
}

struct CalculatorImpl: Calculator {
    
    init() {
    }
    
    // 足し算
    func addition(_ lhs: Int64, to rhs: Int64) ->Int64 {
        
        return lhs + rhs
    }
    
    // 引き算
    func subtraction(_ lhs: Int64, from rhs: Int64) ->Int64 {
        
        return lhs - rhs
    }
    
    // 掛け算
    func maltiplication(_ lhs: Int64, by rhs: Int64) ->Int64 {
        
        return lhs * rhs
    }
    
    // わり算
    func division(_ lhs: Int64, by rhs: Int64) ->Double {
        
        return Double(lhs) / Double(rhs)
    }
}
