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
        guard var tempWord = title?.lowercased() else { return .invalid(Properties.invalidTitle, Properties.InvalidMessage) }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return .invalid("Word not possible","You can't spell that word from \(String(describing: title))")
            }
        }
        
        return .valid
    }
    
    func isOriginal(word: String) -> GameStatus {
        return usedWords.contains(word) ? .duplicate("Word used already", "Be more original!") : .valid
    }
    
    func isReal(word: String) -> GameStatus {
        if word.utf16.count < 3 { return .tooShort("Word Too Short", "Require minimum 3 letter word") }
        if word == title { return .tooShort("Start Word", "You can't use given word as answer!")  }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let value = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en").location
        return value == NSNotFound ? .valid : .invalid("Word not possible","You can't spell that word from \(String(describing: title))")
    }
}
