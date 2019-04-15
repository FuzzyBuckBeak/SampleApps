//
//  ViewController + GameLogic.swift
//  Anagram
//
//  Created by Apo on 4/14/19.
//  Copyright © 2019 Apo. All rights reserved.
//

import UIKit

extension ViewController {
    func startGame() {
        gameView.chosenWordLabel.text = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
    }
    
    func isValid(word: String, mainWord: String) -> Bool {
        let mainWord = mainWord.lowercased()
        let subWord = word.lowercased()
        
        if  isPossible(mainWord: mainWord, subWord: subWord),
            !isOriginal(word: subWord),
            isReal(word: word) {
            return true
        }
        return false
    }
    
    private func isPossible(mainWord: String, subWord: String) -> Bool {
        var tempWord = mainWord.lowercased()
        for letter in subWord {
            guard let position = tempWord.firstIndex(of: letter) else { return false }
            tempWord.remove(at: position)
        }
        return true
    }

    private func isOriginal(word: String) -> Bool {
        return usedWords.contains(word)
    }

    private func isReal(word: String) -> Bool {
       // if word == title { return  .startWord(ScramblerConstants.startWordError.title, ScramblerConstants.startWordError.message)  }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let value = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en").location
        return value == NSNotFound ? true : false
    }
}
