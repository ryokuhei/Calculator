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
    @IBOutlet weak var calculateText: UITextField!
    // 計算開始ボタン
    @IBOutlet weak var calculateButton: CastomButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: CalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupDelegate()
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
        clearButton.setImage(UIImage(named: "clear_2"), for: .normal)
        clearButton.setImage(UIImage(named: "clear_1"), for: .highlighted)
        clearButton.addTarget(self, action: #selector(self.clearFormulaTextView), for: .touchUpInside)
        
        self.calculateText.addSubview(clearButton)
        self.calculateText.clearButtonMode = .always
        
    }
    @objc private func clearFormulaTextView() {
        self.calculateText.text?.removeAll()
    }
    
    private func setupKeyboard() {
        
        let keyboard = CalculationKeyboardBuilder.build()
        keyboard.delegate = self
        self.calculateText.inputView = keyboard
        self.calculateText.inputAccessoryView = keyboard.toolbar

        // キーボード開閉アニメーション *処理内容はUIViewController+Extension.swiftに記載
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(customKeyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(customKeyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    private func setupDelegate() {
        self.calculateText.delegate = self
    }
    
    private func setupNotification() {
        
        // キーボード開閉アニメーション *処理内容はUIViewController+Extension.swiftに記載
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setupViewModelInputs() {
        
        if let viewModel = self.viewModel {
            let calculateText = self.calculateText.rx.text
            calculateText.bind(to: viewModel.inputs.formula).disposed(by: disposeBag)
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

extension CalculatorViewController: UITextFieldDelegate {
    
    // Enterでキーボードを閉じる
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.calculateText.resignFirstResponder()
//
//        return true
//    }
}

extension CalculatorViewController: CalculationKeyboardDelegate {

    // 数式テキストに文字を挿入
    func input(key: String) {
        if let range = self.calculateText.selectedTextRange {
            self.calculateText.replace(range, withText: key)
        }
    }
    
    // 数式テキストをクリア
    func clear() {
        self.calculateText.text?.removeAll()
    }
    
    // 計算を行う
    func done() {
        self.view.endEditing(true)
        self.viewModel?.inputs.doCalculate.onNext(())
    }

    // 数式テキストの文字削除
    func back() {
       
        // キャレットの範囲を取得
        if let range = self.calculateText.selectedTextRange {
            // キャレットで範囲を指定しなかった場合、1つ前の文字を削除
            if range.isEmpty {
                guard let start = self.calculateText.position(from: range.start, offset: -1) else {
                    return
                }
                guard let oneBeforeRange = self.calculateText.textRange(from: start, to: range.end) else {
                    return
                }
                self.calculateText.replace(oneBeforeRange, withText: "")
            } else {
            // キャレットで範囲を指定した場合、範囲の文字を削除
                self.calculateText.replace(range, withText: "")
            }
            
        }
        
    }
}
