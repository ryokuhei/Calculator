//
//  CalculationKeyboardViewModel.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CalculationKeyboardInputs {
    var tapZero: PublishSubject<Void> {get}
    var tapOne: PublishSubject<Void> {get}
    var tapTwo: PublishSubject<Void> {get}
    var tapThree: PublishSubject<Void> {get}
    var tapFour: PublishSubject<Void> {get}
    var tapFive: PublishSubject<Void> {get}
    var tapSix: PublishSubject<Void> {get}
    var tapSeven: PublishSubject<Void> {get}
    var tapEight: PublishSubject<Void> {get}
    var tapNine: PublishSubject<Void> {get}
    var tapPlus: PublishSubject<Void> {get}
    var tapMinus: PublishSubject<Void> {get}
    var tapMultipled: PublishSubject<Void> {get}
    var tapDivided: PublishSubject<Void> {get}
}

protocol CalculationKeyboardOutputs {
    var inputToTarget: Observable<String> {get}
}

protocol CalculationKeyboardViewModel {
    var inputs: CalculationKeyboardInputs {get}
    var outputs: CalculationKeyboardOutputs {get}
}

class CalculationKeyboardViewModelImpl: CalculationKeyboardViewModel, CalculationKeyboardInputs, CalculationKeyboardOutputs {
    lazy var inputs: CalculationKeyboardInputs = {self}()
    lazy var outputs: CalculationKeyboardOutputs = {self}()
    
    // tap event
    var tapZero  = PublishSubject<Void>()
    var tapOne   = PublishSubject<Void>()
    var tapTwo   = PublishSubject<Void>()
    var tapThree = PublishSubject<Void>()
    var tapFour  = PublishSubject<Void>()
    var tapFive  = PublishSubject<Void>()
    var tapSix   = PublishSubject<Void>()
    var tapSeven = PublishSubject<Void>()
    var tapEight = PublishSubject<Void>()
    var tapNine  = PublishSubject<Void>()
    var tapPlus  = PublishSubject<Void>()
    var tapMinus = PublishSubject<Void>()
    var tapMultipled = PublishSubject<Void>()
    var tapDivided   = PublishSubject<Void>()
    
    // タップされた値を通知する
    lazy var inputToTarget: Observable<String> = {
        return Observable.of(zero,
                             one,
                             two,
                             three,
                             four,
                             five,
                             six,
                             seven,
                             eight,
                             nine,
                             plus,
                             minus,
                             multipled,
                             divided
            )
            .merge()
            .share(replay: 1)
    }()
    
    // タップしたボタンの値に変換
    lazy var zero: Observable<String> = {
        return tapZero.map {"0"}.share(replay: 1)
    }()
    lazy var one: Observable<String> = {
        return tapOne.map {"1"}.share(replay: 1)
    }()
    lazy var two: Observable<String> = {
        return tapTwo.map {"2"}.share(replay: 1)
    }()
    lazy var three: Observable<String> = {
        return tapThree.map {"3"}.share(replay: 1)
    }()
    lazy var four: Observable<String> = {
        return tapFour.map {"4"}.share(replay: 1)
    }()
    lazy var five: Observable<String> = {
        return tapFive.map {"5"}.share(replay: 1)
    }()
    lazy var six: Observable<String> = {
        return tapSix.map {"6"}.share(replay: 1)
    }()
    lazy var seven: Observable<String> = {
        return tapSeven.map {"7"}.share(replay: 1)
    }()
    lazy var eight: Observable<String> = {
        return tapEight.map {"8"}.share(replay: 1)
    }()
    lazy var nine: Observable<String> = {
        return tapNine.map {"9"}.share(replay: 1)
    }()
    lazy var plus: Observable<String> = {
        return tapPlus.map {Operator.plus.rawValue}.share(replay: 1)
    }()
    lazy var minus: Observable<String> = {
        return tapMinus.map {Operator.minus.rawValue}.share(replay: 1)
    }()
    lazy var multipled: Observable<String> = {
        return tapMultipled.map {Operator.multiplied.rawValue}.share(replay: 1)
    }()
    lazy var divided: Observable<String> = {
        return tapDivided.map {Operator.divded.rawValue}.share(replay: 1)
    }()
}
