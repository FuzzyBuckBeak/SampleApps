//
//  UILabelExtension.swift
//  Mantra
//
//  Created by Apo on 4/19/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit

extension UIView {
    func showView(_ view: UIView) {
       animate(view: view)
       view.isHidden = false
    }
    
    func hideView(_ view: UIView) {
        animate(view: view)
        view.isHidden = true
    }
    
    private func animate(view: UIView) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.duration = 0.75;
        layer.add(animation, forKey: "fade")
    }
}
