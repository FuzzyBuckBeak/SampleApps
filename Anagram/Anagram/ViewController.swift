//
// ViewController.swift
// Anagram
//
// Created by: FuzzyBuckBeak on 4/13/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/
import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var toolbar: UIView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
      //  textField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
       // NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func resetTapped() {
        
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
                self.toolbar.frame.origin.y += deltaY
            }, completion: nil)
    }
}

extension ViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text)
    }
}
