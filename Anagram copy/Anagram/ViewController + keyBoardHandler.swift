//
//  ViewController + Utility.swift
//  Anagram
//
//  Created by Apo on 4/14/19.
//  Copyright © 2019 Apo. All rights reserved.
//

import UIKit

extension ViewController  {
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let isKeyboardShown = notification.name == UIResponder.keyboardWillShowNotification
            gameView.myViewBottomConstriants.constant = isKeyboardShown ? keyboardFrame!.height - self.view.safeAreaInsets.bottom : 0
            UIView.animate(withDuration: duration,
                           delay: 0.0,
                           options: .curveEaseIn,
                           animations: {
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
