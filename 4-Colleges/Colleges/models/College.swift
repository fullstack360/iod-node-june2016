//
//  College.swift
//  Colleges
//
//  Created by Dan Kwon on 6/20/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit

class College: NSObject {
    
    var id: String!
    var name: String!
    var location: String!
    var type: String!
    var mascot: String!
    var league: String!
    var summary: String?
    
    func populate(collegeInfo: Dictionary<String, AnyObject>){
        
        self.name = collegeInfo["name"] as? String
        self.id = collegeInfo["id"] as? String
        self.location = collegeInfo["location"] as? String
        self.mascot = collegeInfo["mascot"] as? String
        self.type = collegeInfo["type"] as? String
        self.league = collegeInfo["league"] as? String
        
//        self.summary = collegeInfo["description"] as? String
        if let _description = collegeInfo["description"] as? String {
            self.summary = _description
        }

        
    }

}
