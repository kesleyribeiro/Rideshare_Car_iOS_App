//
//  LeftSideMenuVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 12/6/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import Firebase

class LeftSideMenuVC: UIViewController, UITextFieldDelegate {
    
    // MARK: Vars
    
    var currentUserId = Auth.auth().currentUser?.uid
    var appDelegate = AppDelegate.getAppDelegate()
    
    // MARK: IBOutlets
    
    @IBOutlet weak var userAccountTypeLbl: UILabel!
    @IBOutlet weak var userAccountTypeImage: UIImageView!
    @IBOutlet weak var userEmailImage: UIImageView!
    @IBOutlet weak var userImage: RoundImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var pickupModeStatusLbl: UILabel!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var LoginOutBtn: UIButton!
    
    // MARK: Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        appDelegate.menuContainerVC.toggleLeft()
        
        if Auth.auth().currentUser == nil {
            
            userAccountTypeImage.isHidden = true
            userEmailImage.isHidden = true
            userAccountTypeLbl.text = ""
            userEmailLbl.text = ""
            userImage.isHidden = true
            pickupModeLbl.isHidden = true
            pickupModeStatusLbl.isHidden = true
            pickupModeSwitch.isHidden = true
            LoginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            observePassengersAndDrivers()
            userEmailLbl.text = Auth.auth().currentUser?.email
            userAccountTypeImage.isHidden = false
            userEmailImage.isHidden = false
            userImage.isHidden = false
            LoginOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    // MARK: IBAction

    @IBAction func switchWasChanged(_ sender: Any) {
        if pickupModeSwitch.isOn {
                pickupModeStatusLbl.text = "ON"
            DataService.instanceDS.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": true])
        } else {
                pickupModeStatusLbl.text = "OFF"
            DataService.instanceDS.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": false])
        }
    }
    
    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let signUpLoginVC = storyboard.instantiateViewController(withIdentifier: "signUpLoginVC") as? SignUpLoginVC
            present(signUpLoginVC!, animated: true, completion: nil)
        } else {
            do {
                try Auth.auth().signOut()
                
                self.view.layoutIfNeeded()

                userAccountTypeLbl.text = ""
                userImage.isHidden = true
                userEmailLbl.text = ""
                userAccountTypeImage.isHidden = true
                userEmailImage.isHidden = true
                
                pickupModeLbl.isHidden = true
                
                pickupModeStatusLbl.isHidden = true
                pickupModeStatusLbl.text = ""
                
                pickupModeSwitch.isHidden = true
                
                print("\nUser logout with success.")
                
                LoginOutBtn.setTitle("Sign Up / Login", for: .normal)

            } catch (let error) {
                print("\nError: \(error)")
            }
        }
    }
    
    // MARK: Function
    
    func observePassengersAndDrivers() {
        
        DataService.instanceDS.REF_PASSENGERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLbl.text = "PASSENGER"
                        self.userAccountTypeImage.isHidden = false
                        self.userAccountTypeImage.image = UIImage(named: "Passenger")
                        self.pickupModeLbl.isHidden = true
                        self.pickupModeSwitch.isHidden = true
                        self.pickupModeStatusLbl.isHidden = true
                    }
                }
            }
        })
        
        DataService.instanceDS.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLbl.text = "DRIVER"
                        self.userAccountTypeImage.isHidden = false
                        self.userAccountTypeImage.image = UIImage(named: "Driver")
                        self.pickupModeLbl.isHidden = false
                        self.pickupModeSwitch.isHidden = false
                        self.pickupModeStatusLbl.isHidden = false
                        self.pickupModeSwitch.isOn = false
                        
//                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
//                        self.pickupModeSwitch.isOn = switchStatus
                    }
                }
            }
        })
    }
    
    // Hidden keyboard when user touch in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

   
}
