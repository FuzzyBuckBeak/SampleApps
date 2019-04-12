//
// ViewController.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

class ViewController: UIViewController {
    
    var answer = 0
    var countries: [String] = []
    var score:Int  {
        set {
            UserDefaults.shared.score = newValue
        }
        get {
            return UserDefaults.shared.score
        }
    }
    var gameView: GameView! {
        guard isViewLoaded else { return nil }
        return (view as! GameView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.setupView()
        gameView.gameViewDelegate = self
        
        if let startWordsURL = Bundle.main.url(forResource: "countries", withExtension: "txt") {
            if let countriesList = try? String(contentsOf: startWordsURL) {
                countries = countriesList.components(separatedBy: "\n")
                countries = Array(countries.dropLast())
            }
        }
        startGame()
    }
    
    
    func startGame() {
        gameView.scoreLabel.fadeValue(value: String(score))
        answer = Int.random(in: 0...3)
        countries.shuffle()
        print(countries[0...3])
        gameView.firstFlagButton.fadeImage(imageName: countries[0])
        gameView.secondFlagButton.fadeImage(imageName: countries[1])
        gameView.thirdFlagButton.fadeImage(imageName: countries[2])
        gameView.fourthFlagButton.fadeImage(imageName: countries[3])
        gameView.countryNameLabel.fadeValue(value: countries[answer])
    }
    
    func updateUI(score: Int, isCorrect: Bool, view: UIButton) {
        if !isCorrect {
            view.shake()
        } else {
            startGame()
        }
    }
}

