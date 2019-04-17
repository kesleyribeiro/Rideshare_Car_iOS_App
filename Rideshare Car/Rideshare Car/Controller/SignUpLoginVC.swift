//
//  SignUpLoginVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 3/11/19.
//  Copyright © 2019 Kesley Ribeiro. All rights reserved.
//

import UIKit

class SignUpLoginVC: UIViewController {

    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.changeKeyboardFrame()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: IBAction
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Function
    
    @objc func tapOnScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    
}
