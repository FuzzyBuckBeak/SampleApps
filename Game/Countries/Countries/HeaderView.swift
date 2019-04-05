//
// File.swift
// Countries
//
// Created by: FuzzyBuckBeak on 4/4/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import Foundation
import UIKit

protocol commonHeaderViewProtocol {
    func didPauseTap()
}

@IBDesignable

class HeaderView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerValueLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        contentView = loadViewFromNib()
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[v]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: nil,
                views: ["v":contentView]
            )
        )
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[v]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: nil, views: ["v":contentView]
            )
        )
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

extension HeaderView {
    @IBInspectable var pauseButtonCornerRadius: Double {
        get {
            return Double(pauseButton.layer.cornerRadius)
        }set {
            pauseButton.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var backGroundColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.backgroundColor!)
        }
        set {
            self.layer.backgroundColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
}
