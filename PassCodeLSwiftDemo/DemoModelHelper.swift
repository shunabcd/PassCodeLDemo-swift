//
//  DemoModelHelper.swift
//  PassCodeLSwiftDemo
//
// Created by s-sakurai on 2017/04/07.
//  Copyright © 2017年 s-sakurai. All rights reserved.
//

import Foundation
import PassCodeL

class DemoModelHelper: PassCodeL {
    
    let passcodeKey = "DemoAppPassCode"
    let touchIDKey = "DemoAppTouchID"
    
    lazy var defaults: UserDefaults = {
        return UserDefaults.standard
    }()
    
    var touchid :String?
    
    var hasPassCode: Bool {
        
        if passcode != nil {
            return true
        }
        return false
    }
    
    var passcode: [String]? {
        return defaults.value(forKey: passcodeKey) as? [String] ?? nil
    }
    
    var isTouchID: Bool {
        if touchID != nil {
            return true
        }
        return false
    }
    
    var touchID: String? {
        
        return defaults.value(forKey: touchIDKey) as? String ?? nil
    }
    
    func savePassCode(_ passcode: [String]) {
        
        defaults.set(passcode, forKey: passcodeKey)
        defaults.synchronize()
    }
    
    func deletePassCode() {
        
        defaults.removeObject(forKey: passcodeKey)
        defaults.synchronize()
    }
    
    func saveTouchID(_ touchID: String) {
        
        defaults.set(touchID, forKey: touchIDKey)
        defaults.synchronize()
    }
    
    func deleteTouchID() {
        defaults.removeObject(forKey: touchIDKey)
        defaults.synchronize()
    }
    
}
