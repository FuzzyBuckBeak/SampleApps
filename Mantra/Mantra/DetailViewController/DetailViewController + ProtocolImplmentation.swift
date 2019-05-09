//
//  ViewController + ProtocolImplmentation.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension DetailViewController: MantraViewProtocol {
    func viewTapped(_ sender: Any) {
        handleOverlay(hide: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.handleOverlay(hide: true)
        }
    }
    
    func playButtonTapped(_ sender: UIButton) {
        guard let audioPlayer = audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        mantraView.handlePausePlayButton(isPaused: !audioPlayer.isPlaying)
    }
    
    func counterTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: nil, message: "Please enter Chant count", preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Submit", style: .default) { [weak ac, weak self] action in
            guard let filteredValue = ac?.textFields?[0].text,
                  let count = Int(filteredValue) else { return }
            self?.setAudioLoop(count: count)
        }
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func settingsTapped(_ sender: UIButton) {
        
    }
}

extension DetailViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        loopCount += 1
        if loopCount < totalCounter { audioPlayer?.play() }
        updateViewForLoopCount(loopCount: loopCount, totalCount: totalCounter)
    }
}
