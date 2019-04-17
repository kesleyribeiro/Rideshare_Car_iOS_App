//
//  UIExtension.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 3/11/19.
//  Copyright © 2019 Kesley Ribeiro. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTo(alphaValeu: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValeu
        }
    }
    
    func changeKeyboardFrame() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(_:)), name: NSNotification.Name.keyboardChange, object: nil)
    }
    
    @objc func keyboardChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let currentFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - currentFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}

extension Notification.Name {
    static let keyboardChange = Notification.Name(rawValue: "keyboardChange")
}


