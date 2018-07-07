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
    
    var calculateText: PublishSubject<String?> {get}
    var calculate: PublishSubject<Void> {get}
}

protocol CalculatorOutputs {
    
    var displayToLeftNumber: Observable<String> {get}
    var displayToRightNumber: Observable<String> {get}
    var displayToResultNumber: Observable<String> {get}
    var displayToOperate: Observable<String> {get}
    
    var showError: Observable<String>{get}
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
    var calculateText = PublishSubject<String?>()
    var calculate = PublishSubject<Void>()

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
    
    lazy var showError: Observable<String> = {
        return error
    }()

    
    // 通知用
    var leftNumber   = PublishSubject<Int>()
    var rightNumber  = PublishSubject<Int>()
    var operate      = PublishSubject<Operator>()
    var resultNumber = PublishSubject<Float>()
    
    var error = PublishSubject<String>()

    // 計算用
    private lazy var calculation: Observable<Formula?> = {
        return calculate
            .throttle(0.3, scheduler: MainScheduler.instance)
            .withLatestFrom(calculateText) { $1 }
            .map { [unowned self] calculate ->Formula? in
                guard let calculate = calculate else {
                    return nil
                }

                return Formula(calculate)
            }
            .share(replay: 1)
    }()
    
    let disposeBag = DisposeBag()
    init(calculator: Calculator) {
        
        self.calculator = calculator
        
        calculation.subscribe(onNext: {
            formula in
                guard let formula = formula else {
                    self.error.onNext("")
                    return
                }
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
                }
                self.resultNumber.onNext(result)

            },
            onError: { error in
                self.error.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
    
}
