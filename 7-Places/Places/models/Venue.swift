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
    var address = ""
    var lat: Double!
    var lng: Double!
    
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.lat, self.lng)
    }
    
    // Title and subtitle for use by selection UI.
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
        
        if let _vicinity = venueInfo["vicinity"] as? String {
            self.address = _vicinity
        }

        if let _geometry = venueInfo["geometry"] as? Dictionary<String, AnyObject> {
//            print("\(_geometry)")
            
            
            if let _location = _geometry["location"] as? Dictionary<String, AnyObject>{
                
                if let _lat = _location["lat"] as? Double {
                    self.lat = _lat
//                    print("\(self.lat)")
                }
                
                if let _lng = _location["lng"] as? Double {
                    self.lng = _lng
//                    print("\(self.lng)")
                }
                
            }
            
            
        }

        
        
    }

}
