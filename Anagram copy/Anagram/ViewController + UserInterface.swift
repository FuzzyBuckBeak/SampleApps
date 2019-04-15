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
}
