//
//  UIViewController+Extension.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // キーボードを表示させた時にviewの位置を上に移動させる
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? NSValue)?.cgRectValue
        let duration: TimeInterval = (notification?.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? Double) ?? 0.0
        
        UIView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            self.view.transform = transform
        })
    }
    
    // キーボードを閉じた時にviweの位置を元に戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval = (notification?.userInfo?["UIKeyboardAnimationCurveUserInfoKey"] as? Double) ?? 0.0
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = CGAffineTransform.identity
        })
        
    }
    // キーボードを表示させた時にviewの位置を上に移動させる
    @objc func customKeyboardWillShow(notification: Notification?) {
        let rect = UIScreen.main.bounds
        let duration: TimeInterval = (notification?.userInfo?["UIKeyboardAnimationDurationUserInfoKey"] as? Double) ?? 0.0
       print("notification")
        UIView.animate(withDuration: duration, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height / 3 ))
            self.view.transform = transform
        })
    }
    
    // キーボードを閉じた時にviweの位置を元に戻す
    @objc func customKeyboardWillHide(notification: Notification?) {
        let duration: TimeInterval = (notification?.userInfo?["UIKeyboardAnimationCurveUserInfoKey"] as? Double) ?? 0.0
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = CGAffineTransform.identity
        })
        
    }
}

