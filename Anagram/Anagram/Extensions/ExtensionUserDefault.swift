//
// ExtensionNSUserDefault.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation

extension UserDefaults {
    static var shared = UserDefaults()
    var score: Int {
        get { return integer(forKey: "Score") }
        set { set(newValue, forKey: "Score") }
    }
    
    func reset() {
        score = 0
    }
}
