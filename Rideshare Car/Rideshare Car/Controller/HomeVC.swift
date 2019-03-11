//
//  HomeVC.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 28/11/18.
//  Copyright © 2018 Kesley Ribeiro. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actBtn: RoundShadowButton!
    
    var delegate: CenterDelegate?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
    }

    
    // MARK: IBAction
    
    @IBAction func actBtnWasPressed(_ sender: Any) {
        actBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    
    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeft()
    }
    
}

