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

    var timer = Timer()
    var duration: Int = 120
    var isTimerRunning = false
    
    var chosenWord: String!
    
    var gameView: GameView! {
        guard isViewLoaded else { return nil }
        return (view as! GameView)
    }
    
    var score:Int  {
        set { UserDefaults.shared.score = newValue }
        get { return UserDefaults.shared.score }
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
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        startGame()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameView.viewIsAboutToAppear()
        timerAction(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameView.viewIsAboutToDisapper()
        timerAction(true)
    }
}

extension ViewController: GameViewProtocol {
    func infoTapped(_ sender: UIButton) {
        if let chosenWord = chosenWord {
            let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: chosenWord)
            self.present(ref, animated: true, completion: nil)
        }
    }
    
    func viewIsAboutToAppear() {
        gameView.viewIsAboutToAppear()
    }
    
    func viewIsAboutToDisapper() {
        gameView.viewIsAboutToDisapper()
    }
    
    func pauseTapped(_ sender: UIButton) {
        appPaused()
    }
    
    func appPaused() {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "_PauseViewController") as?  PauseViewController {
            viewcontroller.parentcontroller = self
            viewcontroller.view.backgroundColor = self.view.backgroundColor
            viewIsAboutToDisapper()
            addChild(child: viewcontroller)
            timerAction(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textValue = textField.text,
           textValue.count > 0,
           let mainWord = chosenWord {
           handoffToLogicController(subValue: textValue, mainValue: mainWord)
        }
        return false
    }
}

