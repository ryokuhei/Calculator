//
//  SplashViewController.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {
    
    @IBOutlet weak var appName: UITextField!
    var viewModel: SplashViewModel?
    var wireframe: SplashWireframe?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewModelOutputs()
        self.setupViewModelInputs()
    }
    

    func inject(viewModel: SplashViewModel, wireframe: SplashWireframe) {
        self.viewModel = viewModel
        self.wireframe = wireframe
    }
    
    private func setupViewModelInputs() {
        self.viewModel?.inputs.viewDidLoad.onNext(())
    }
    
    private func setupViewModelOutputs() {
        self.viewModel?.outputs.showStartViewController
            .asDriver(onErrorJustReturn: ())
            .drive(onNext:{ [unowned self] in
                self.feedOutAnimation {
                    self.wireframe?.showStartViewController()
                }
            }).disposed(by: disposeBag)
    }

    private func feedOutAnimation(completion: (() ->Void)? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                animations: { [weak self] in
                    self?.appName.alpha = 0
            }, completion: { finished in
                    completion?()
            })
        }
        
    }
    
}
