//
//  DemoConfig.swift
//  PassCodeLSwiftDemo
//
// Created by s-sakurai on 2017/04/07.
//  Copyright © 2017年 s-sakurai. All rights reserved.
//

import Foundation
import PassCodeL

struct DemoConfig: PassCodeLConfig {
    
    var passCodeL: PassCodeL
    var isTouchIDAllowed:Bool = true
    
    var maxAttempts:Int = 3
    
    init(model: PassCodeL) {
        
        self.passCodeL = model
    }
    
    init() {
        self.passCodeL = DemoModelHelper()
    }
}
