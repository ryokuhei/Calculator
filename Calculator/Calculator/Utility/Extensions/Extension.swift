//
//  Extension.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation


public struct Extension<Base> {
    
    let base: Base
    
    init(_ base: Base) {
        
        self.base = base
    }
}

protocol ExtensionCompatible {
    
    associatedtype CompatibleType
    
    static var ex: Extension<CompatibleType>.Type {get}
    var ex: Extension<CompatibleType> {get}
    
}

extension ExtensionCompatible {
    
    public static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    public var ex: Extension<Self> {
        return Extension(self)
    }
}

extension String {
    
    func isFormula() ->Bool {
        let pattern = "^([0-9])+[+-/*//]([+0-9])+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.count > 0
    }
    
    func isMatchesRegularExpression(pattern: String) ->Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.count > 0
    }
}

extension Float {
    func trancrationOfDecimalPlace(numberOf decimalPlace: Int) ->Float {
        let test = pow(10, decimalPlace).hashValue
        print(test)
        
        var decimalPoint = 10
        for _ in 1...decimalPlace {
            decimalPoint = decimalPoint * 10
        }
        return floor(self * Float(decimalPoint)) / Float(decimalPoint)
    }
}
