//
//  Venue.swift
//  Places
//
//  Created by Dan Kwon on 6/27/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import MapKit

class Venue: NSObject, MKAnnotation {
    var name = ""
    var location: Dictionary<String, AnyObject>?
    var address = ""
    var city = ""
    var state = ""
    var latitude: Double?
    var longitude: Double?
    
    // MARK: - MKAnnotation Overrides:
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
    }
    
    var title: String? {
        return self.name
    }
    
    var subtitle: String? {
        return self.address
    }
    
    func populate(venueInfo: Dictionary<String, AnyObject>){
        if let _name = venueInfo["name"] as? String {
            self.name = _name
        }
        
        self.location = venueInfo["location"] as? Dictionary<String, AnyObject>

        if let _lat = location!["lat"] as? Double {
            self.latitude = _lat
        }

        if let _lng = location!["lng"] as? Double {
            self.longitude = _lng
        }

        
        if let _address = location!["address"] as? String {
            self.address = _address
        }

        if let _city = location!["city"] as? String {
            self.city = _city
        }

        if let _state = location!["state"] as? String {
            self.state = _state
        }

        
        
    }

}
