//
//  RoundShadowView.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 11/29/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
