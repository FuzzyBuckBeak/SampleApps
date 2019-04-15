//
// GameView.swift
// Anagram
//
// Created by: FuzzyBuckBeak on 4/13/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

protocol GameViewProtocol: class {
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool
}

class GameView: UIView {

    weak var delegate: GameViewProtocol?
    @IBOutlet weak var myViewBottomConstriants: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var validWordTextView: UITextView!
    @IBOutlet weak var validWordView: UIStackView!
    @IBOutlet weak var validWordViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var chosenWordLabel: UILabel!
    
    func setupView() {
        inputTextField.becomeFirstResponder()
        inputTextField.returnKeyType = .done
        inputTextField.autocapitalizationType = .allCharacters
        inputTextField.delegate = self
        validWordTextView.delegate = self
        headerView.layer.cornerRadius = headerView.frame.height / 2
        pauseButton.layer.cornerRadius = pauseButton.frame.height / 2
    }
}

extension GameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let gameViewDelegate = delegate else { fatalError() }
        return gameViewDelegate.textFieldShouldReturn(textField)
    }
}

extension GameView: UITextViewDelegate {
    
}
