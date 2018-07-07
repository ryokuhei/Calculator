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

class CalculatorViewController: UIViewController {
    
    // 計算結果表示用ラベル
    @IBOutlet weak var leftNumber: UILabel!
    @IBOutlet weak var rightNumber: UILabel!
    @IBOutlet weak var resultNumber: UILabel!
    
    // 演算子
    @IBOutlet weak var operate: UILabel!
    
    // 単位メモ用テキスト
    @IBOutlet weak var leftUnit: UITextField!
    @IBOutlet weak var rightUnit: UITextField!
    @IBOutlet weak var resultUnit: UITextField!
    
    // 計算用インプットテキスト
    @IBOutlet weak var calculateText: UITextField!
    // 計算開始ボタン
    @IBOutlet weak var calculateButton: CastomButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel: CalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calculateText.delegate = self
        
        self.setupDelegate()
        self.setupNotification()
        self.setupViewModelOutputs()
        self.setupViewModelInputs()
    }
    
    func inject(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupDelegate() {
        self.calculateText.delegate = self
    }
    
    private func setupNotification() {
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setupViewModelInputs() {
        
        if let viewModel = self.viewModel {
            let calculateText = self.calculateText.rx.text
            calculateText.bind(to: viewModel.inputs.calculateText).disposed(by: disposeBag)
            let tapCalculate = self.calculateButton.rx.tap
            tapCalculate.bind(to: viewModel.inputs.calculate).disposed(by: disposeBag)
        }
    }
    
    private func setupViewModelOutputs() {
        
        self.viewModel?.outputs.displayToLeftNumber.bind(to: self.leftNumber.rx.text).disposed(by: disposeBag)
        self.viewModel?.outputs.displayToRightNumber.bind(to: self.rightNumber.rx.text).disposed(by: disposeBag)
        
        self.viewModel?.outputs.displayToOperate.bind(to: self.operate.rx.text).disposed(by: disposeBag)
        self.viewModel?.outputs.displayToResultNumber.bind(to: self.resultNumber.rx.text).disposed(by: disposeBag)
        
        self.viewModel?.outputs.showError
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { errorMessage in
                self.showError(message: errorMessage)
            })
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func showError(message: String) {
        KRProgressHUD.showError(withMessage: message)
    }
    
}

extension CalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.calculateText.resignFirstResponder()
        
        return true
    }
}
