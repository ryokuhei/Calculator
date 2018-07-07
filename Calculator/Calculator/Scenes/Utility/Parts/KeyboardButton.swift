//
//  KeyboardButton.swift
//  Calculator
//
//  Created by ryoku on 2018/07/08.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class KeyboardButton: UIButton {
    
    // corner
    @IBInspectable var cornerRadius: CGFloat = 3.0
    
    // border
    @IBInspectable var borderColor: UIColor = UIColor.MyTheme.keyboardButtonBorder
    @IBInspectable var borderWidth: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = (self.cornerRadius > 0)
        
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        
        super.draw(rect)
    }
    
}
