//
// GameViewController + ActionHandler.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation
import UIKit

extension ViewController: GameViewProtocol {
    func flagTapped(_ sender: UIButton) {
        if sender.tag == answer {
            score += 20
            updateUI(score: score, isCorrect: true, view: sender)
        } else {
            score -= 5
            updateUI(score: score, isCorrect: false, view: sender)
        }
    }
    
    func pauseTapped(_ sender: UIButton) {
        if let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "_PauseViewController") as?  PauseViewController {
            viewcontroller.parentcontroller = self
            viewcontroller.view.backgroundColor = self.view.backgroundColor
            addChild(child: viewcontroller)
        }
    }
}
