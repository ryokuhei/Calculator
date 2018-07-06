//
//  SplashBuilder.swift
//  Calculator
//
//  Created by ryoku on 2018/07/06.
//  Copyright © 2018 ryokuhei_sato. All rights reserved.
//

import Foundation
import UIKit

class SplashBuilder {

    static func build() ->UIViewController {
        let vc = R.storyboard.splash.instantiateInitialViewController()
        let vm: SplashViewModel =  SplashViewModelImpl()
        let wireframe = SplashWireframe()
        vc?.inject(viewModel: vm, wireframe: wireframe)
        
        return vc!
    }
}
