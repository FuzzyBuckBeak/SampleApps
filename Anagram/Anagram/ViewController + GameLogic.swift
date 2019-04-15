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
        gameView.chosenWordLabel.text = allWords.randomElement()?.uppercased()
        gameView.scoreLabel.text = ""
        gameView.inputTextField.text = ""
        gameView.validWordTextView.text = ""
        usedWords.removeAll(keepingCapacity: true)
        initializeTimer()
    }
    
    func initializeTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let strongSelf = self else { return }
            strongSelf.duration += 1
            if strongSelf.duration < 20 {
                strongSelf.updateTimerUI(strongSelf.duration)
            } else {
                timer.invalidate()
                strongSelf.duration = 0
                strongSelf.startGame()
            }
        })
    }
    
    private func isValid(word: String, mainWord: String) -> Bool {
        let mainWord = mainWord.lowercased()
        let subWord = word.lowercased()
        
        if  isPossible(mainWord: mainWord, subWord: subWord),
            !isOriginal(word: subWord),
            isReal(word: word, mainWord: mainWord) {
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

    private func isReal(word: String, mainWord: String) -> Bool {
        if word == mainWord { return  false }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let value = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en").location
        return value == NSNotFound ? true : false
    }
    
    func handoffToLogicController(subValue: String, mainValue: String) {
        if (isValid(word: subValue, mainWord: mainValue)) {
            handleSucessCase(value: subValue)
        } else {
            handleFailureCase()
        }
        updateScoreBoard(score: score)
    }
    private func handleSucessCase(value: String) {
        updateTextView(value)
        gameView.inputTextField.text = ""
        score += value.count * 5
    }
    
    private func handleFailureCase() {
         gameView.inputTextField.shake()
        score -= 10
    }
}
