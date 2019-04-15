//
//  ViewController + UserInterface.swift
//  Anagram
//
//  Created by Apo on 4/14/19.
//  Copyright © 2019 Apo. All rights reserved.
//

import UIKit

extension ViewController {
    func updateTextView(_ value: String) {
        usedWords.append(value)
        print(gameView.validWordTextView.contentSize.height)
        print(gameView.validWordView.frame.height)
        gameView.validWordTextView.text = gameView.validWordTextView.text + "\n" + value
        if gameView.validWordTextView.contentSize.height < gameView.validWordView.frame.height  {
            gameView.validWordViewHeightConstraints.constant = gameView.validWordTextView.contentSize.height
        }
        gameView.validWordTextView.scrollTextViewToBottom()
    }
    
    func updateScoreBoard(score: Int) {
        gameView.scoreLabel.fadeValue(value: String(score))
    }
    
    
    func updateTimerUI(_ duration: Int) {
        let value = ((duration % 3600) / 60, (duration % 3600) % 60)
        gameView.timerLabel.text = String(value.0) + ":" + String(value.1)
    }
}