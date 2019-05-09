//
//  ViewController.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit
import Foundation
import MediaPlayer
import AVFoundation
import Pulley

class DetailViewController: UIViewController {
    var mantraView: MantraView! {
        guard isViewLoaded else { return nil }
        return (view as! MantraView)
    }
    
    fileprivate let remoteCommandCenter = MPRemoteCommandCenter.shared()
    var audioPlayer: AVAudioPlayer!
    var totalCounter: Int = 2
    var loopCount: Int = 0
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        //Setup View
        mantraView?.setupView()
        mantraView.delegate = self
        
        //Initialize audio player
        initializeAudioPlayer()
        
        //Handle 
        setupRemoteTransportControls()
        setupNowPlaying()
    }
}

