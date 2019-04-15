//
//  ViewController + GameLogic.swift
//  Anagram
//
//  Created by Apo on 4/14/19.
//  Copyright © 2019 Apo. All rights reserved.
//

import UIKit

enum WordType {
    case invalid
    case duplicate
    case impossible
}

extension ViewController {
    func startGame() {
        gameView.chosenWordLabel.text = allWords.randomElement()?.uppercased()
        gameView.scoreLabel.text = String(score)
        gameView.inputTextField.text = ""
        gameView.validWordTextView.text = ""
        gameView.timerLabel.text = "00:00"
        usedWords.removeAll(keepingCapacity: true)
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    @objc func handleTimer() {
        if duration < 120 {
            duration += 1
            updateTimerUI(duration)
        } else {
            restartGame()
        }
    }
    
    func timerPaused(_ isPaused: Bool) {
        if isPaused {
            timer.invalidate()
        } else {
            startTimer()
        }
    }

    func restartGame() {
        timer.invalidate()
        duration = 0
        score = 0
        startGame()
    }
    
    private func isValid(word: String, mainWord: String) -> WordType? {
        let mainWord = mainWord.lowercased()
        let subWord = word.lowercased()
        
        guard isPossible(mainWord: mainWord, subWord: subWord) != false else { return WordType.impossible}
        guard isOriginal(word: subWord) == false else { return WordType.duplicate }
        guard isReal(word: word, mainWord: mainWord) != false else { return WordType.invalid }
        return nil
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
        if let type = isValid(word: subValue, mainWord: mainValue) {
            handleFailureCase(type: type)
        } else {
            handleSucessCase(value: subValue)
            usedWords.append(subValue.lowercased())
        }
        updateScoreBoard(score: score)
    }
    private func handleSucessCase(value: String) {
        updateTextView(value)
        gameView.inputTextField.text = ""
        score += value.count * 5
    }
    
    private func handleFailureCase(type: WordType) {
        gameView.inputTextField.shake()
        switch type {
        case .invalid: score -= 5
        case .impossible: score -= 10
        default: return
        }
    }
}
