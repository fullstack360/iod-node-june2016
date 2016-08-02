//
//  Profile.swift
//  startups-ios
//
//  Created by Forrest Filler on 8/1/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit

class Profile: NSObject {
    var _id: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var password: String?
    
    func populate(profileInfo: Dictionary<String, AnyObject>) {
        
        let props = ["_id","firstname","lastname","email","password"]
        for prop in props {
            let value = profileInfo[prop]
            self.setValue(value, forKey: prop)
        }
    }
    
    /*
     if let _shares = startupInfo["shares"] as? Int {
     self.shares = _shares
     }
     */
}