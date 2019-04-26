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
    
    @IBOutlet weak var userImage: RoundImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var pickupModeStatusLbl: UILabel!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var LoginOutBtn: UIButton!
    
    // MARK: Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pickupModeLbl.isHidden = true
        pickupModeStatusLbl.isHidden = true
        pickupModeSwitch.isHidden = true
        pickupModeSwitch.isOn = false
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil {
            userAccountTypeLbl.text = ""
            userEmailLbl.text = ""
            userImage.isHidden = true
            LoginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            userEmailLbl.text = Auth.auth().currentUser?.email
            userAccountTypeLbl.text = ""
            userImage.isHidden = false
            pickupModeStatusLbl.text = "OFF"
            LoginOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    // MARK: IBAction
    
    @IBAction func switchWasChanged(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeStatusLbl.text = "ON"
            appDelegate.menuContainerVC.toggleLeft()
            DataService.instanceDS.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": true])
        } else {
            pickupModeStatusLbl.text = "OFF"
            appDelegate.menuContainerVC.toggleLeft()
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

                userAccountTypeLbl.text = ""
                userImage.isHidden = true
                userEmailLbl.text = ""
                pickupModeLbl.isHidden = true
                pickupModeStatusLbl.isHidden = true
                pickupModeSwitch.isHidden = true
                LoginOutBtn.setTitle("Sign Up / Login", for: .normal)
                
                pickupModeStatusLbl.text = "OFF"
                DataService.instanceDS.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickupModeEnabled": false])

            } catch (let error) {
                print(error)
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
                    }
                }
            }
        })
        
        DataService.instanceDS.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLbl.text = "DRIVER"
                        self.pickupModeLbl.isHidden = false
                        self.pickupModeSwitch.isHidden = false
                        self.pickupModeStatusLbl.isHidden = false
                        self.pickupModeStatusLbl.text = "OFF"
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
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
