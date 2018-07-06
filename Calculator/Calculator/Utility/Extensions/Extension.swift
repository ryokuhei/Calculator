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
