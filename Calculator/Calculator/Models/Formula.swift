//
//  Formula.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation

struct Formula {
    let lhs: Int
    let rhs: Int
    let operate: Operator
    
    init?(_ formula: String) {
        guard formula.isFormula() else {
            return nil
        }
        
        let components : [String]
        let operate: Operator
        if formula.contains("+") {
            operate = .plus
            components = formula.components(separatedBy: "+")
        } else if formula.contains("-") {
            operate = .minus
            components = formula.components(separatedBy: "-")
        } else if formula.contains("*") {
            operate = .multiplied
            components = formula.components(separatedBy: "*")
        } else if formula.contains("×") {
            operate = .multiplied
            components = formula.components(separatedBy: "×")
        } else if formula.contains("/") {
            operate = .divded
            components = formula.components(separatedBy: "/")
        } else if formula.contains("÷") {
            operate = .divded
            components = formula.components(separatedBy: "÷")
        } else {
            return nil
        }
        
        guard let lhs = Int(components[0]),
              let rhs = Int(components[1]) else {
                return nil
        }
        self.lhs = lhs
        self.rhs = rhs
        self.operate = operate
    }
}
