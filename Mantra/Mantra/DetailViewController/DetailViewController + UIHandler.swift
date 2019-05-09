//
//  ViewController + UIHandler.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import Foundation
import UIKit

extension DetailViewController {
    func updateViewForLoopCount(loopCount: Int, totalCount: Int) {
        mantraView.chantCount.text = String(String(loopCount) + "/" + String(totalCount))
    }
    
    func handleOverlay(hide: Bool) {
        if hide {
          if audioPlayer.isPlaying { mantraView.hideView(mantraView.overlayView) }
        } else {
            mantraView.showView(mantraView.overlayView)
        }
    }
}
