//
// ViewController.swift
// Anagram
//
// Created by: FuzzyBuckBeak on 4/13/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/
import Foundation
import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var keyboardFrame: CGRect!
    var allWords: [String] = []
    var usedWords: [String] = []
    
    var gameView: GameView! {
        guard isViewLoaded else { return nil }
        return (view as! GameView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.setupView()
        gameView.delegate = self
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        allWords = ["SILKWORM"]
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        startGame()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //parentView.layoutIfNeeded()
    }
}

extension ViewController: GameViewProtocol {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textValue = textField.text,
           textValue.count > 0,
           let mainWord = gameView.chosenWordLabel.text {
            if (isValid(word: textValue, mainWord: mainWord)) {
                updateTextView(textValue)
                textField.text = ""
            } else {
                textField.shake()
            }
        }
        return false
    }
}

