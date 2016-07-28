//
//  Startup.swift
//  startups-ios
//
//  Created by Dan Kwon on 7/25/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import Alamofire

class Startup: NSObject {
    var _id: String?
    var name: String?
    var city: String?
    var founder: String?
    var image: String?
    var shares: Int?
    var imageData: UIImage?
    var isFetching = false
    
    func populate(startupInfo: Dictionary<String, AnyObject>){
        
        let props = ["_id", "name", "city", "founder"]
        for prop in props {
            let value = startupInfo[prop]
            self.setValue(value, forKey: prop)
        }
        
        if let _shares = startupInfo["shares"] as? Int {
            self.shares = _shares

        }
        
        if let _image = startupInfo["image"] as? String {
            if (_image.characters.count == 0){
                self.image = "placeholder.jpg"
            }
            else {
                self.image = _image
                
            }
        }
    }
    
    
    func fetchImage(){
        if (self.isFetching == true){
            return
        }
        
        self.isFetching = true
        
        let url = "https://ff-startups.herokuapp.com/images/"+self.image!
        Alamofire.request(.GET, url, parameters:nil).response { (req, res, data, error) in
            self.isFetching = false
            
            if (error != nil){ // error, don't do anything
                return
            }
            
            if let img = UIImage(data: data!) { // success!
                self.imageData = img
                
                let notificationCtr = NSNotificationCenter.defaultCenter()
                let notification = NSNotification(name: "ImageDownloaded", object: nil)
                notificationCtr.postNotification(notification)
            }
        }
    }
}








