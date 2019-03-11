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
}


