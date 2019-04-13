//
// GameView.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation
import UIKit

protocol GameViewProtocol: class {
    func flagTapped(_ sender: UIButton)
    func pauseTapped(_ sender: UIButton)
}

class GameView: UIView {
    weak var gameViewDelegate: GameViewProtocol?
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var firstFlagButton: UIButton!
    @IBOutlet weak var secondFlagButton: UIButton!
    @IBOutlet weak var thirdFlagButton: UIButton!
    @IBOutlet weak var fourthFlagButton: UIButton!
    
    func setupView() {
        headerView.layer.cornerRadius = headerView.frame.height / 2.5
        footerView.layer.cornerRadius = footerView.frame.height / 2.5
        pauseButton.layer.cornerRadius = pauseButton.frame.height / 2
        firstFlagButton.layer.borderWidth = 1
        secondFlagButton.layer.borderWidth = 1
        thirdFlagButton.layer.borderWidth = 1
        fourthFlagButton.layer.borderWidth = 1
        
        let color = UIColor.white.cgColor
        firstFlagButton.layer.borderColor = color
        secondFlagButton.layer.borderColor = color
        thirdFlagButton.layer.borderColor = color
        fourthFlagButton.layer.borderColor = color
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        gameViewDelegate?.pauseTapped(sender)
    }
    
    @IBAction func flagButtonTapped(_ sender: UIButton) {
        gameViewDelegate?.flagTapped(sender)
    }
}
