//
//  CircleView.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 11/29/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor?  {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = borderColor?.cgColor
    }
}
