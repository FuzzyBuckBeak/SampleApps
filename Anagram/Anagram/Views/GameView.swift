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
    func pauseTapped(_ sender: UIButton)
    func infoTapped(_ sender: UIButton)
    func viewIsAboutToAppear()
    func viewIsAboutToDisapper()
}

class GameView: UIView {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    weak var delegate: GameViewProtocol?
    @IBOutlet weak var myViewBottomConstriants: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var validWordTextView: UITextView!
    @IBOutlet weak var validWordView: UIStackView!
    @IBOutlet weak var validWordViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var chosenWordLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    func setupView() {
        inputTextField.returnKeyType = .done
        inputTextField.autocapitalizationType = .allCharacters
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(textChanged(_:)), for: UIControl.Event.editingChanged)
        headerView.layer.cornerRadius = headerView.frame.height / 2
        pauseButton.layer.cornerRadius = pauseButton.frame.height / 2
        viewIsAboutToAppear()
    }
    
    @IBAction func infoTapped(_ sender: UIButton) {
        guard let gameViewDelegate = delegate else { fatalError() }
        return gameViewDelegate.infoTapped(sender)
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        guard let gameViewDelegate = delegate else { fatalError() }
        return gameViewDelegate.pauseTapped(sender)
    }
    
    func viewIsAboutToAppear() {
        inputTextField.becomeFirstResponder()
    }
    
    func viewIsAboutToDisapper() {
         inputTextField.resignFirstResponder()
    }
}

extension GameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let gameViewDelegate = delegate else { fatalError() }
        return gameViewDelegate.textFieldShouldReturn(textField)
    }
    
    @objc func textChanged(_ sender: UITextField) {
        sender.text = sender.text?.uppercased()
    }
}
