//
//  CustomView.swift
//  Calculator
//
//  Created by ryoku on 2018/07/08.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CastomView: UIView {
    
    // corner
    @IBInspectable var cornerRadius: CGFloat = 15.0
    
    // border
    @IBInspectable var borderColor: UIColor = UIColor.MyTheme.viewBorder
    @IBInspectable var borderWidth: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.clipsToBounds = (self.cornerRadius > 0)
        
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.backgroundColor = UIColor.MyTheme.viewBackground.cgColor

        super.draw(rect)
    }
    
}
