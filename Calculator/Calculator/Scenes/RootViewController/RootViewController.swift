//
//  RootViewController.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

final class RootViewController: UIViewController {
    
    var current: UIViewController! {
        willSet {
            
            self.addChildViewController(newValue)
            newValue.view.frame = self.view.bounds
            self.view.addSubview(newValue.view)
            newValue.didMove(toParentViewController: self)
        }
        didSet {
            
            oldValue.didMove(toParentViewController: self)
            oldValue.view.removeFromSuperview()
            oldValue.removeFromParentViewController()
        }
    
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.current = self.initiateSplashViewController()
        // willSet,didSetが初期設定が行われない為、初期設定を行う
        self.addChildViewController(self.current)
        self.current.view.frame = self.view.bounds
        self.view.addSubview(self.current.view)
        self.current.didMove(toParentViewController: self)
    }
    
    private func initiateSplashViewController() ->UIViewController {
        
        return SplashBuilder.build()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
