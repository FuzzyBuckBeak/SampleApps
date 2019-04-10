//
//  GameError.swift
//  Word Scambler
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation
import UIKit

enum GameStatus {
    case misspelled(String, String)
    case duplicate(String, String)
    case invalid(String, String)
    case startWord(String, String)
    case tooShort(String, String)
    case valid
}

extension ViewController {
    func handleError(_ gameStatus: GameStatus) {
        var errorTitle: String
        var errorMessage: String
        
        switch gameStatus {
        case .misspelled(let title, let message): errorTitle = title; errorMessage = message
        case .duplicate(let title, let message): errorTitle = title; errorMessage = message
        case .invalid(let title, let message): errorTitle = title; errorMessage = message
        case .startWord(let title, let message): errorTitle = title; errorMessage = message
        case .tooShort(let title, let message): errorTitle = title; errorMessage = message
        default: return
        }
        
        let alertView = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        present(alertView, animated: true, completion: nil)
    }
    
    func isPossible(word: String) -> GameStatus {
        guard var tempWord = title?.lowercased() else { return .invalid(ScramblerConstants.invalidError.title, ScramblerConstants.invalidError.message) }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return .invalid(ScramblerConstants.invalidError.title, ScramblerConstants.invalidError.message)
            }
        }
        
        return .valid
    }
    
    func isOriginal(word: String) -> GameStatus {
        return usedWords.contains(word) ? .duplicate(ScramblerConstants.duplicateError.title, ScramblerConstants.duplicateError.message) : .valid
    }
    
    func isReal(word: String) -> GameStatus {
        if word.utf16.count < 3 { return .tooShort(ScramblerConstants.tooShortError.title, ScramblerConstants.tooShortError.message) }
        if word == title { return  .startWord(ScramblerConstants.startWordError.title, ScramblerConstants.startWordError.message)  }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let value = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en").location
        return value == NSNotFound ? .valid : .invalid(ScramblerConstants.invalidError.title, ScramblerConstants.invalidError.message)
    }
}
