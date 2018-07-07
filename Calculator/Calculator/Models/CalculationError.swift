//
//  CalculationError.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation

enum CalculationError: Error {

    case divideByZero
    case resultValueToLarge
    case inputValueToLarge
    case invalidValue
    case leftHandSideIsNotEntered
    case rightHandSideIsNotEntered
    case unknownError
    
    func getMessage() -> String {
        switch self {
        case .divideByZero:
            return "0で割ることはできません。"
        case .resultValueToLarge:
            return "計算結果が大き過ぎた為、表示できません。"
        case .inputValueToLarge:
            return "入力した値が大き過ぎる為、計算できません。"
        case .invalidValue:
            return "不正な値が入力されました。"
        case .leftHandSideIsNotEntered:
            return "左辺が入力されていません。"
        case .rightHandSideIsNotEntered:
            return "右辺が入力されていません。"
        case .unknownError:
            return "原因不明のエラーが検出されました。"
        }
    }
    
}
