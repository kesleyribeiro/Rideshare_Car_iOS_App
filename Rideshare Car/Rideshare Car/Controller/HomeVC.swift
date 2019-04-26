//
//  HomeVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 28/11/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate, UITextFieldDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var requestBtn: RoundShadowButton!
    
    var delegate: CenterDelegate?
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenCar")!, iconInitialSize: CGSize(width: 100, height: 100), backgroundColor: .white)
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // Call the function
        addRevealingSplashView()
    }

    
    // MARK: IBAction
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeft()
        self.view.endEditing(true)
    }
    
    @IBAction func requestCarBtnWasPressed(_ sender: Any) {
        requestBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    // MARK: Function
    
    func addRevealingSplashView() {
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }
    

    // Hidden keyboard when user touch in the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

