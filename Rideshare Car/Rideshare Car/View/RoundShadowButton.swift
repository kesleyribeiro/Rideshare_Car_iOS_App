//
//  RoundShadowButton.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 11/29/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class RoundShadowButton: UIButton {

    var originalSize: CGRect?
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        
        originalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0)
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 27
        
        if shouldLoad {
            
            self.addSubview(spinner)
            
            self.setTitle("", for: .normal)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
                
            }) { (finished) in
                
                if finished == true {
                
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    spinner.fadeTo(alphaValeu: 0.3, withDuration: 1.0)                    
                }
            }
            self.isUserInteractionEnabled = false
            
        } else {
            
            self.isUserInteractionEnabled = true
            
            for subview in self.subviews {
                if subview.tag == 27 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            })
        }
    }
    
}
