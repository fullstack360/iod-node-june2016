//
//  Post.swift
//  instagram
//
//  Created by Dan Kwon on 7/11/16.
//  Copyright © 2016 Velocity360. All rights reserved.


import UIKit
import Alamofire

class Post: NSObject {
    
    var captionText: String?
    var imageUrl: String?
    var image: UIImage?
    var isFetching = false
    
    func fetchImage(){
        if (self.imageUrl == nil){ // no image, ignore
            return
        }
        
        if (self.isFetching == true){
            return
        }
        
        self.isFetching = true
        Alamofire.request(.GET, self.imageUrl!, parameters:nil).response { (req, res, data, error) in
            self.isFetching = false
            if (error != nil){
                return
            }
            
            if let img = UIImage(data: data!) {
                self.image = img
                
                let notification = NSNotification(name:"ImageDownloaded", object:nil)
                let notificationCenter = NSNotificationCenter.defaultCenter()
                notificationCenter.postNotification(notification)
            }
        }
    }
    
    func populate(postInfo: Dictionary<String, AnyObject>){
        
        if let _caption = postInfo["caption"] as? Dictionary<String, AnyObject>{
            if let text = _caption["text"] as? String{
                self.captionText = text
            }
        }
        
        if let _images = postInfo["images"] as? Dictionary<String, AnyObject>{
            if let standard_resolution = _images["standard_resolution"] as? Dictionary<String, AnyObject>{
                
                if let url = standard_resolution["url"] as? String {
                    self.imageUrl = url
//                    print("IMAGE URL = \(self.imageUrl)")
                    
                }
            }
        }
    }
    
    
    

}
