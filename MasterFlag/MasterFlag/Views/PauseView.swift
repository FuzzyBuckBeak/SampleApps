//
// PauseView.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.

/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

protocol PauseViewProtocol: class {
    func resumeTapped()
    func resetTapped()
}

class PauseView: UIView {

    weak var delegate: PauseViewProtocol?
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    func setupView() {
        overlayView.layer.cornerRadius = overlayView.frame.height / 20
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        resumeButton.layer.cornerRadius = resumeButton.frame.height / 2
    }
    
    @IBAction func resumeButtonTapped(_ sender: Any) {
        delegate?.resumeTapped()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        delegate?.resetTapped()
    }
}
