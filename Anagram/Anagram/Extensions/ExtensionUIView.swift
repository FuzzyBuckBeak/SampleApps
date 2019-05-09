//
// ExtensionUIView.swift
// MasterFlag
//
// Created by: FuzzyBuckBeak on 4/11/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-15.0, 13.0, -10.0, 5, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func showViewWithAlphaAnimation() {
        UIView.animate(withDuration: 2.0, animations: { [weak self] in
            self?.alpha = 1
        }) { value in
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.alpha = 0
            })
        }
    }
}

extension UILabel {
    func fadeValue(value: String) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = 0.75;
        layer.add(animation, forKey: "fade")
        text = value
    }
}

