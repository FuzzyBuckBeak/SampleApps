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
        headerView.layer.cornerRadius = headerView.frame.height / 3
        footerView.layer.cornerRadius = footerView.frame.height / 3
        pauseButton.layer.cornerRadius = pauseButton.frame.height / 2
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        gameViewDelegate?.pauseTapped(sender)
    }
    
    @IBAction func flagButtonTapped(_ sender: UIButton) {
        gameViewDelegate?.flagTapped(sender)
    }
}
