//
//  SplashViewModel.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashInputs {
    var viewDidLoad: PublishSubject<Void> {get}
}

protocol SplashOutputs {
    var showStartViewController: Observable<Void> {get}
}

protocol SplashViewModel {
    var inputs: SplashInputs {get}
    var outputs: SplashOutputs {get}
}

class SplashViewModelImpl: SplashViewModel, SplashInputs, SplashOutputs {
    
    lazy var inputs: SplashInputs = {self}()
    lazy var outputs: SplashOutputs = {self}()
    
    var viewDidLoad = PublishSubject<Void>()
    
    // ロードより0.5秒後にイベントを発行
    lazy var showStartViewController: Observable<Void> = {
        return viewDidLoad.debounce(0.5, scheduler: MainScheduler.instance)
    }()
}
