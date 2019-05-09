//
//  ViewController + AudioHandler.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension DetailViewController {
    func initializeAudioPlayer() {
        do {
            if let fileURL = Bundle.main.path(forResource: "Mritunjaya", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
        let audioSession =  AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true)
        } catch {
            
        }
        audioPlayer?.delegate = self
        audioPlayer?.play()
    }
    
    func setAudioLoop(count: Int) {
        totalCounter = count
        updateViewForLoopCount(loopCount: loopCount, totalCount: totalCounter)
        handleOverlay(hide: true)
    }
}
