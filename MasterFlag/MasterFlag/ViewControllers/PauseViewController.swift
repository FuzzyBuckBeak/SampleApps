//
// PauseViewController.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

class PauseViewController: UIViewController, PauseViewProtocol {
    
    weak var parentcontroller: ViewController?
    var pauseView: PauseView! {
        guard isViewLoaded else { return nil }
        return (view as! PauseView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseView.setupView()
        pauseView.delegate = self
    }
    
    func resumeTapped() {
        self.remove()
    }
    
    func resetTapped() {
        UserDefaults.shared.reset()
        self.remove()
        parentcontroller?.startGame()
    }
    
    func exitTapped() {
        exit(0)
    }
}
