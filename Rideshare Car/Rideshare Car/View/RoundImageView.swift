//
//  RoundImageView.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 11/29/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
       setupView()
    }
    
    func setupView() {
        
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
