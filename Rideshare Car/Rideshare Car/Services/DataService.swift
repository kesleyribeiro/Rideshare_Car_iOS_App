//
//  DataService.swift
//  Rideshare Car
//
//  Created by Kesley Ribeiro on 4/25/19.
//  Copyright © 2019 Kesley Ribeiro. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instanceDS = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_PASSENGERS = DB_BASE.child("passengers")
    private var _REF_DRIVERS = DB_BASE.child("drivers")
    private var _REF_TRIPS = DB_BASE.child("trips")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_PASSENGERS: DatabaseReference {
        return _REF_PASSENGERS
    }
    
    var REF_DRIVERS: DatabaseReference {
        return _REF_DRIVERS
    }
    
    var REF_TRIPS: DatabaseReference {
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid: String, userdata: Dictionary<String, Any>, isDriver: Bool) {
        
        // Checking the kind of user - driver or passengers
        if isDriver {
            REF_DRIVERS.child(uid).updateChildValues(userdata)
        } else {
            REF_PASSENGERS.child(uid).updateChildValues(userdata)
        }
    }
}
