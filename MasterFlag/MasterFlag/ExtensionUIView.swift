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

extension UIButton {
    func fadeImage(imageName: String) {
        let image = UIImage(named: imageName)
        UIView.transition(with: self, duration: 1.0, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.setImage(image, for: .normal)
        }, completion: nil)
    }
}

