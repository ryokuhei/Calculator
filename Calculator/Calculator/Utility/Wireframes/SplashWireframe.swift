//
//  SplashWireframe.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation

struct SplashWireframe {
    
    func showStartViewController(completion: (() ->Void)? = nil) {
        let vc = R.storyboard.main.instantiateInitialViewController()
        AppDelegate.shared.rootViewController.current = vc
        completion?()
    }
}
