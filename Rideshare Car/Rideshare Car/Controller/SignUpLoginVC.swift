//
//  SignUpLoginVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 3/11/19.
//  Copyright © 2019 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpLoginVC: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var optionsSegmented: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passworfTextField: UITextField!
    @IBOutlet weak var authBtn: RoundShadowButton!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passworfTextField.delegate = self

        view.changeKeyboardFrame()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: IBAction
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        
        if emailTextField.text != nil && passworfTextField.text != nil {
            
            authBtn.animateButton(shouldLoad: true, withMessage: nil)
            
            self.view.endEditing(true)
            
            if let email = emailTextField.text, let password = passworfTextField.text {

                // Auth with existing user
                Auth.auth().signIn(withEmail: email, password: password,
                    completion: { (user, error) in
                    // Success
                    if error == nil {
                        if let user = user {
                            // User is a Passenger
                            if self.optionsSegmented.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.user.providerID] as [String: Any]
                                
                                DataService.instanceDS.createFirebaseDBUser(uid: user.user.uid, userdata: userData, isDriver: false)
                            }
                            // User is a Driver
                            else {
                                let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                
                                DataService.instanceDS.createFirebaseDBUser(uid: user.user.uid, userdata: userData, isDriver: true)
                            }
                        }
                        print("\nEmail user authenticated with success.\n")
                        self.dismiss(animated: true, completion: nil)
                    }
                    // If not exist a user then create a new user
                    else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .wrongPassword:
                                print("\nThat password was wrong.\n")
                            default:
                                print("\nAn unexpected error occured, please try again.\n")
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            // Error
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                switch errorCode {
                                    case .emailAlreadyInUse:
                                        print("\nThat email is already in use, please use another email.\n")
                                    case .invalidEmail:
                                        print("\nThat is an invalid email, please try again.\n")
                                    default:
                                        print("\nAn unexpected error occured, please try again.\n")
                                    }
                                }
                            }
                            // Success to create a new user
                            else {
                                if let user = user {
                                    // User is a Passenger
                                    if self.optionsSegmented.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.user.providerID] as [String: Any]
                                        
                                        DataService.instanceDS.createFirebaseDBUser(uid: user.user.uid, userdata: userData, isDriver: false)
                                        
                                        print("\nNew passenger user created with success.\n")
                                    }
                                    // User is a Driver
                                    else {
                                        let userData = ["provider": user.user.providerID, "userIsDriver": true, "isPickupModeEnabled": false, "driverIsOnTrip": false] as [String: Any]
                                        
                                        DataService.instanceDS.createFirebaseDBUser(uid: user.user.uid, userdata: userData, isDriver: true)
                                        
                                        print("\nNew driver user created with success.\n")
                                    }
                                }
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    
    // MARK: Function
    
    @objc func tapOnScreen(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    // Hidden keyboard when user touch in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
