//
//  GradientView.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 11/29/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView, UITextFieldDelegate {
    
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)  {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 0.8021190068) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)        
        
        self.layer.addSublayer(gradientLayer)        
    }
    
    // Hidden keyboard when user touch in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true) 
    }
    
}
