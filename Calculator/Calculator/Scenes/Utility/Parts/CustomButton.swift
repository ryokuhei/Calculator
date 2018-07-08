//
//  CustomButton.swift
//  Calculator
//
//  Created by ryoku on 2018/07/07.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CastomButton: UIButton {
    
    // corner
    @IBInspectable var cornerRadius: CGFloat = 10.0
    
    // border
    @IBInspectable var borderColor: UIColor = UIColor.MyTheme.buttonBorder
    @IBInspectable var borderWidth: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = (self.cornerRadius > 0)
        
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.shadowColor = UIColor.MyTheme.keyboardButtonShadow.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        super.draw(rect)
    }
    
}
