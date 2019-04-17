//
//  LeftSideMenuVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 12/6/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit

class LeftSideMenuVC: UIViewController, UITextFieldDelegate {

    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: IBAction
    
    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let signUpLoginVC = storyboard.instantiateViewController(withIdentifier: "signUpLoginVC") as? SignUpLoginVC
        present(signUpLoginVC!, animated: true, completion: nil)
        
    }
    
    // Hidden keyboard when user touch in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

   
}
