//
//  CalculationKeyboard.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class CalculationKeyboard: UIView {
    
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!

    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var multiplied: UIButton!
    @IBOutlet weak var divided: UIButton!
    
    @IBOutlet weak var back: KeyboardButton!
    
    var delegate: CalculationKeyboardDelegate?
    var viewModel: CalculationKeyboardViewModel?
    var toolbar: UIToolbar?
    
    let disposeBag = DisposeBag()
    
    func inject(viewModel: CalculationKeyboardViewModel) {
        self.viewModel = viewModel
    }
    
    init(frame: CGRect, viewModel: CalculationKeyboardViewModel) {
        super.init(frame: frame)
        
        self.viewModel = viewModel
        self.setupView()
        self.setupToolBar()

        self.setupViewModelOutputs()
        self.setupViewModelInputs()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupView()
        self.setupToolBar()
        self.setupViewModelOutputs()
        self.setupViewModelInputs()
    }
    
    private func setupView() {
        
       if let view = R.nib.calculationKeyboard.firstView(owner: self) {

            addSubview(view)
    
            view.translatesAutoresizingMaskIntoConstraints = false
            let bindings = ["view": view]
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[view]|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: bindings))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[view]|",
                options: NSLayoutFormatOptions(rawValue: 0),
                metrics: nil,
                views: bindings))
        }
    }
    
    private func setupToolBar() {
        
        self.toolbar = UIToolbar()
        self.toolbar?.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.tapDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.tapClearButton))
        self.toolbar?.setItems([clearButton, spaceButton, doneButton], animated: false)
        self.toolbar?.isUserInteractionEnabled = true
        self.toolbar?.sizeToFit()
    }
    
    
    private func setupViewModelInputs() {
        
        if let viewModel = self.viewModel {
            
            let tapZero = self.zero.rx.tap
            tapZero.bind(to: viewModel.inputs.tapZero)
                .disposed(by: disposeBag)
    
            let tapOne = self.one.rx.tap
            tapOne.bind(to: viewModel.inputs.tapOne)
                .disposed(by: disposeBag)
    
            let tapTwo = self.two.rx.tap
            tapTwo.bind(to: viewModel.inputs.tapTwo)
                .disposed(by: disposeBag)

            let tapThree = self.three.rx.tap
            tapThree.bind(to: viewModel.inputs.tapThree)
                .disposed(by: disposeBag)
    
            let tapFour = self.four.rx.tap
            tapFour.bind(to: viewModel.inputs.tapFour)
                .disposed(by: disposeBag)
    
            let tapFive = self.five.rx.tap
            tapFive.bind(to: viewModel.inputs.tapFive)
                .disposed(by: disposeBag)
    
            let tapSix = self.six.rx.tap
            tapSix.bind(to: viewModel.inputs.tapSix)
                .disposed(by: disposeBag)
    
            let tapSeven = self.seven.rx.tap
            tapSeven.bind(to: viewModel.inputs.tapSeven)
                .disposed(by: disposeBag)
    
            let tapEight = self.eight.rx.tap
            tapEight.bind(to: viewModel.inputs.tapEight)
                .disposed(by: disposeBag)
    
            let tapNine = self.nine.rx.tap
            tapNine.bind(to: viewModel.inputs.tapNine)
                .disposed(by: disposeBag)
    
            let tapPlus = self.plus.rx.tap
            tapPlus.bind(to: viewModel.inputs.tapPlus)
                .disposed(by: disposeBag)
    
            let tapMinus = self.minus.rx.tap
            tapMinus.bind(to: viewModel.inputs.tapMinus)
                .disposed(by: disposeBag)
    
            let tapMultiplied = self.multiplied.rx.tap
            tapMultiplied.bind(to: viewModel.inputs.tapMultipled)
                .disposed(by: disposeBag)
    
            let tapDivided = self.divided.rx.tap
            tapDivided.bind(to: viewModel.inputs.tapDivided)
                .disposed(by: disposeBag)
            
            let tapBack = self.back.rx.tap
            tapBack.bind(to: viewModel.inputs.tapBack)
                .disposed(by: disposeBag)
        }
        
    }
    
    private func setupViewModelOutputs() {
        
        self.viewModel?.outputs.inputToTarget
        .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: {[unowned self] key in
                self.delegate?.input(key: key)
            }).disposed(by: disposeBag)
        
        self.viewModel?.outputs.done
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: {[unowned self] in
                self.delegate?.done()
            }).disposed(by: disposeBag)
        
        self.viewModel?.outputs.clear
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: {[unowned self] in
                self.delegate?.clear()
            }).disposed(by: disposeBag)
        
        self.viewModel?.outputs.back
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: {[unowned self] in
                self.delegate?.back()
            }).disposed(by: disposeBag)
    }
    
    @objc private func tapDoneButton() {
        self.viewModel?.inputs.tapDone.onNext(())
    }
    
    @objc private func tapClearButton() {
        self.viewModel?.inputs.tapClear.onNext(())
    }
    
}

protocol CalculationKeyboardDelegate {
    func input(key: String)
    func clear()
    func done()
    func back()
}
