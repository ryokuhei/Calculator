//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CalculatorInputs {
    
    var formula: PublishSubject<String?> {get}
    var doCalculate: PublishSubject<Void> {get}
}

protocol CalculatorOutputs {
    
    var displayToLeftNumber: Observable<String> {get}
    var displayToRightNumber: Observable<String> {get}
    var displayToResultNumber: Observable<String> {get}
    var displayToOperate: Observable<String> {get}
    
    var showError: Observable<CalculationError?>{get}
}

protocol CalculatorViewModel: CalculatorInputs, CalculatorOutputs {
    var inputs: CalculatorInputs {get}
    var outputs: CalculatorOutputs {get}
}

class CalculatorViewModelImpl: CalculatorViewModel, CalculatorOutputs {
    
    lazy var inputs: CalculatorInputs = {self}()
    lazy var outputs: CalculatorOutputs = {self}()
    
    var calculator: Calculator
    
    // 入力系オブザーバー
    var formula = PublishSubject<String?>()
    var doCalculate = PublishSubject<Void>()

    // 画面表示系オブザーバー
    lazy var displayToLeftNumber: Observable<String> = {
        return leftNumber
            .map {String($0)}
            .share(replay: 1)
    }()
    lazy var displayToRightNumber: Observable<String> = {
        return rightNumber
            .map {String($0)}
            .share(replay: 1)
    }()
    lazy var displayToOperate: Observable<String> = {
        return operate
            .map {$0.rawValue}
            .share(replay: 1)
    }()
    lazy var displayToResultNumber: Observable<String> = {
        return resultNumber
            .map {String($0)}
            .share(replay: 1)
    }()
    
    lazy var showError: Observable<CalculationError?> = {
        return error
    }()

    
    // 通知用
    var leftNumber   = PublishSubject<Int>()
    var rightNumber  = PublishSubject<Int>()
    var operate      = PublishSubject<Operator>()
    var resultNumber = PublishSubject<Float>()
    
    var error = PublishSubject<CalculationError?>()

    // start calculate
    private lazy var calculate: Observable<String?> = {
        return self.doCalculate
            .throttle(0.3, scheduler: MainScheduler.instance)
            .withLatestFrom(formula) { $1 }
    }()

    // validation
    private lazy var calculationValid: Observable<Result<Formula, CalculationError>> = {
         return calculate
            .map { [unowned self] formula ->Result<Formula, CalculationError> in
                guard let formula = formula else {
                    return Result(error: .unknownError)
                }
                guard let formulaEntity = Formula(formula) else {
                    if !formula.isMatchesRegularExpression(pattern: "^([0-9])+") {
                        return Result(error: .leftHandSideIsNotEntered)
                        
                    } else if !formula.isMatchesRegularExpression(pattern: "[+-/*//]([+0-9])+") {
                        return Result(error: .rightHandSideIsNotEntered)
                        
                    } else if !formula.isMatchesRegularExpression(pattern: "^([0-9])+[+-/*//]([+0-9])+$") {
                        return Result(error: .invalidValue)
                    } else {
                       return Result(error: .unknownError)
                    }
                }
                
                return Result(value: formulaEntity)
            }
            .share(replay: 1)
    }()
    
    let disposeBag = DisposeBag()
    
    init(calculator: Calculator) {
        
        self.calculator = calculator
        
        calculationValid.subscribe(onNext: { result in
            
                switch result {
                case .failure(let error):
                    self.error.onNext(error)
                case .success(let formula):
                    self.leftNumber.onNext(formula.lhs)
                    self.rightNumber.onNext(formula.rhs)
                    self.operate.onNext(formula.operate)
                
                    var result: Float
                    switch formula.operate {
                        case .plus:
                            result = Float(self.calculator.addition(formula.lhs, to: formula.rhs))
                        case .minus:
                            result = Float(self.calculator.subtraction(formula.lhs, from: formula.rhs))
                        case .multiplied:
                            result = Float(self.calculator.maltiplication(formula.lhs, by: formula.rhs))
                        case .divded:
                            result = self.calculator.division(formula.lhs, by: formula.rhs)
                            if result.isFinite {
                               self.error.onNext(.divideByZero)
                            }
                    }
                    self.resultNumber.onNext(result)
                }

            },
            onError: { error in
                print(error)
                self.error.onNext(.unknownError)
            }).disposed(by: disposeBag)
        
    }
}