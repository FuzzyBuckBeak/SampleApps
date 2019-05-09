//
//  ViewController + GameLogic.swift
//  Anagram
//
//  Created by Apo on 4/14/19.
//  Copyright © 2019 Apo. All rights reserved.
//

import UIKit

enum WordErrorType: String {
    case invalid = "This is not a valid word"
    case duplicate = "You have already created this word"
    case impossible = "This Word is not possible from given word"
    case short = "Length of word should be more than 2"
}

extension ViewController {
    func startGame() {
        if let word = allWords.randomElement()?.uppercased() {
            chosenWord = word
        }
        gameView.chosenWordLabel.text = chosenWord
        gameView.scoreLabel.text = String(score)
        gameView.inputTextField.text = ""
        gameView.validWordTextView.text = ""
        gameView.timerLabel.text = "02:00"
        usedWords.removeAll(keepingCapacity: true)
        startTimer()
    }
    
    func startTimer() {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
    }
    
    @objc func handleTimer() {
        if duration > 0 {
            duration -= 1
            updateTimerUI(duration)
        } else {
            restartGame()
        }
    }
    
    func timerAction(_ pause: Bool) {
        if pause {
            isTimerRunning = false
            timer.invalidate()
        } else {
            startTimer()
        }
    }

    func restartGame() {
        timer.invalidate()
        isTimerRunning = false
        duration = 120
        score = 0
        startGame()
    }
    
    private func isValid(word: String, mainWord: String) -> WordErrorType? {
        let mainWord = mainWord.lowercased()
        let subWord = word.lowercased()
        
        guard isPossible(mainWord: mainWord, subWord: subWord) != false else { return WordErrorType.impossible}
        guard isOriginal(word: subWord) == false else { return WordErrorType.duplicate }
        guard isAcceptLength(word: subWord) != false else { return WordErrorType.short }
        guard isReal(word: word, mainWord: mainWord) != false else { return WordErrorType.invalid }
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
        return UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: word)
//        let checker = UITextChecker()
//        let range = NSRange(location: 0, length: word.utf16.count)
//        let value = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en").location
//        return value == NSNotFound ? true : false
    }
    
    private func isAcceptLength(word: String) -> Bool {
        return word.count > 2
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
    
    private func handleFailureCase(type: WordErrorType) {
        gameView.inputTextField.shake()
        switch type {
        case .invalid: score -= 5; showWarningLabel(WordErrorType.invalid.rawValue)
        case .impossible: score -= 10; showWarningLabel(WordErrorType.impossible.rawValue)
        case .short: showWarningLabel(WordErrorType.short.rawValue)
        case .duplicate: showWarningLabel(WordErrorType.duplicate.rawValue)
        }
    }
}
