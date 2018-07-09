//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import KRProgressHUD

class CalculatorViewController: UIViewController  {
    
    // 計算結果表示用ラベル
    @IBOutlet weak var leftNumber: UILabel!
    @IBOutlet weak var rightNumber: UILabel!
    @IBOutlet weak var resultNumber: UILabel!
    @IBOutlet weak var equal: UILabel!
    
    // 演算子
    @IBOutlet weak var operate: UILabel!
    
    // 計算用インプットテキスト
    @IBOutlet weak var formula: UITextField!
    // 計算開始ボタン
    @IBOutlet weak var calculateButton: CastomButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: CalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupNotification()
        self.setupKeyboard()
        self.setupViewModelOutputs()
        self.setupViewModelInputs()
    }
    
    func inject(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupView() {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(R.image.clear_2(), for: .normal)
        clearButton.setImage(R.image.clear_1(), for: .highlighted)
        clearButton.addTarget(self, action: #selector(self.clearFormulaTextView), for: .touchUpInside)
        
        self.formula.addSubview(clearButton)
        self.formula.clearButtonMode = .always
        
    }
    
    @objc private func clearFormulaTextView() {
        self.formula.text?.removeAll()
    }
    
    private func setupKeyboard() {
        
        let keyboard = CalculationKeyboardBuilder.build()
        keyboard.delegate = self
        self.formula.inputView = keyboard
        self.formula.inputAccessoryView = keyboard.toolbar

        // キーボード開閉アニメーション *処理内容はUIViewController+Extension.swiftに記載
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(customKeyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(customKeyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setupNotification() {
        
        // キーボード開閉アニメーション *処理内容はUIViewController+Extension.swiftに記載
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setupViewModelInputs() {
        
        if let viewModel = self.viewModel {
            let formula = self.formula.rx.text
            formula.bind(to: viewModel.inputs.formula).disposed(by: disposeBag)
            let tapCalculate = self.calculateButton.rx.tap
            tapCalculate.do(onNext: {_ in self.view.endEditing(true)})
                .bind(to: viewModel.inputs.doCalculate).disposed(by: disposeBag)
        }
    }
    
    private func setupViewModelOutputs() {
        
        self.viewModel?.outputs.displayToLeftNumber.bind(to: self.leftNumber.rx.text).disposed(by: disposeBag)
        self.viewModel?.outputs.displayToRightNumber.bind(to: self.rightNumber.rx.text).disposed(by: disposeBag)
        
        self.viewModel?.outputs.displayToOperate.bind(to: self.operate.rx.text).disposed(by: disposeBag)
        self.viewModel?.outputs.displayToResultNumber.bind(to: self.resultNumber.rx.text).disposed(by: disposeBag)
        
        self.viewModel?.outputs.isHideEqual.bind(to: self.equal.rx.isHidden).disposed(by: disposeBag)
        
        self.viewModel?.outputs.showError
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: { error in
                self.showError(message: error?.getMessage())
            })
            .disposed(by: disposeBag)
    }
    
    // 画面タップ時にキーボードが開いていたら閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // errorポップアップ表示
    func showError(message: String? = nil) {
        self.viewModel?.inputs.doDisplayReset.onNext(())
        KRProgressHUD.showError(withMessage: message)
    }
    
}

extension CalculatorViewController: CalculationKeyboardDelegate {

    // 数式テキストに文字を挿入
    func input(key: String) {
        
        if let range = self.formula.selectedTextRange {
            self.formula.replace(range, withText: key)
        }
    }
    
    // 数式テキストをクリア
    func clear() {
        
        self.formula.text?.removeAll()
    }
    
    // 計算を行う
    func done() {
        
        self.view.endEditing(true)
        self.viewModel?.inputs.doCalculate.onNext(())
    }

    // 数式テキストの文字削除
    func back() {
       
        // キャレットの範囲を取得
        if let range = self.formula.selectedTextRange {
            // キャレットで範囲を指定しなかった場合、1つ前の文字を削除
            if range.isEmpty {
                guard let start = self.formula.position(from: range.start, offset: -1) else {
                    return
                }
                guard let oneBeforeRange = self.formula.textRange(from: start, to: range.end) else {
                    return
                }
                self.formula.replace(oneBeforeRange, withText: "")
            } else {
            // キャレットで範囲を指定した場合、範囲の文字を削除
                self.formula.replace(range, withText: "")
            }
            
        }
    }
    
}
