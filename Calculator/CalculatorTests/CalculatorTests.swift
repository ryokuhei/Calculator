//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by ryoku on 2018/07/05.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    let calculator: Calculator = CalculatorImpl()

    func testAddition() {
        let result = calculator.addition(1, to: 9)
        XCTAssertEqual(result, 10)
        let result2 = calculator.addition(9, to: 1)
        XCTAssertEqual(result2, 10)
        let result3 = calculator.addition(0, to: 0)
        XCTAssertEqual(result3, 0)
    }
    
    func testSubtraction() {
        let result = calculator.subtraction(10, from: 1)
        XCTAssertEqual(result, 9)
        let result2 = calculator.subtraction(0, from: 0)
        XCTAssertEqual(result2, 0)
        let result3 = calculator.subtraction(1, from: 9)
        XCTAssertEqual(result3, -8)
    }
    
    func testMultiplication() {
        let result = calculator.maltiplication(1, by: 9)
        XCTAssertEqual(result, 9)
        let result2 = calculator.maltiplication(9, by: 1)
        XCTAssertEqual(result2, 9)
        let result3 = calculator.maltiplication(0, by: 0)
        XCTAssertEqual(result3, 0)
    }
    
    func testDivision() {
        let result = calculator.division(2, by: 10)
        XCTAssertEqual(result, 0.2)
        let result2 = calculator.division(10, by: 2)
        XCTAssertEqual(result2, 5.0)
//        let result3 = calculator.division(10, by: 3)
//        XCTAssertEqual(result3, 3.33333)
        let result4 = calculator.division(10, by: 0)
        XCTAssertTrue(!result4.isFinite)
    }

}
