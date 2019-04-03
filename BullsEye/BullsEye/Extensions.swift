//
// Extensions.swift
// BullsEye
//
// Created by: FuzzyBuckBeak on 4/2/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation

extension Float {
    func RoundedInt() -> Int {
        return Int(roundf(self))
    }
}

extension Int {
    func StringValue() -> String {
        return String(self)
    }
}
