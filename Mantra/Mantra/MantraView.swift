//
//  MantraView.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit

protocol MantraViewProtocol: class {
    func counterTapped(_ sender: UIButton)
    func settingsTapped(_ sender: UIButton)
    func playButtonTapped(_ sender: UIButton)
    func viewTapped(_ sender: Any)
}

class MantraView: UIView {
    weak var delegate: MantraViewProtocol?
    @IBOutlet weak var chantCount: UILabel!
    @IBOutlet weak var lyricsLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func viewTapped(_ sender: Any) {
        delegate?.viewTapped(sender)
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        delegate?.settingsTapped(sender)
    }
    @IBAction func playButtonTapped(_ sender: UIButton) {
        delegate?.playButtonTapped(sender)
    }
    @IBAction func repeatButtonTapped(_ sender: UIButton) {
        delegate?.counterTapped(sender)
    }
    
    func setupView() {
        
    }
    
    func handlePausePlayButton(isPaused: Bool) {
       if isPaused {
            playButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
       } else {
            playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
            hideView(overlayView)
       }
    }
    
}
