//
//  Constants.swift
//  Word Scambler
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation

class ScramblerConstants {
    
    static let misspelledError: (title: String, message: String) = ("", "")
    static let duplicateError: (title: String, message: String) = ("Word used already", "Be more original!")
    static let tooShortError: (title: String, message: String) = ("Word Too Short", "Require minimum 3 letter word")
    static let invalidError: (title: String, message: String)  = ("Word not possible", "You can't spell that word from given word)")
    static let startWordError: (title: String, message: String) = ("Start Word", "You can't use given word as answer!")
}
