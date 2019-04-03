//
// AboutViewController.swift
// BullsEye
//
// Created by: FuzzyBuckBeak on 4/2/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************
 
 
 
 
 
 *****************************************************************************************************************************/

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutBullsEye: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            let request = URLRequest(url: url)
            aboutBullsEye.load(request)
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
