//
//  StartupViewController.swift
//  startups-ios
//
//  Created by Dan Kwon on 7/25/16.
//  Copyright © 2016 Velocity360. All rights reserved.


import UIKit
import Alamofire

class StartupViewController: UIViewController {
    
    var startup: Startup!
    var startupImage: UIImageView!
    var imageTextField: UITextField!
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGrayColor()
        
        self.startupImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.startupImage.image = self.startup.imageData
        self.startupImage.center = CGPoint(x: 0.5*frame.size.width, y: 160)
        view.addSubview(self.startupImage)
        
        var y = self.startupImage.frame.origin.y+self.startupImage.frame.size.height+20
        self.imageTextField = UITextField(frame: CGRect(x: 20, y: y, width: frame.size.width-40, height: 32))
        self.imageTextField.placeholder = "image name"
        self.imageTextField.borderStyle = .RoundedRect
        self.imageTextField.autocapitalizationType = .None
        self.imageTextField.autocorrectionType = .No
        view.addSubview(self.imageTextField)
        y += self.imageTextField.frame.size.height+20
        
        let btnSubmit = UIButton(type: .Custom)
        btnSubmit.backgroundColor = .blueColor()
        btnSubmit.frame = CGRect(x: 20, y: y, width: frame.size.width-40, height: 44)
        btnSubmit.setTitle("Update", forState: .Normal)
        btnSubmit.setTitleColor(.whiteColor(), forState: .Normal)
        btnSubmit.addTarget(self, action: #selector(StartupViewController.updateStartup), forControlEvents: .TouchUpInside)
        view.addSubview(btnSubmit)
        
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.startup.name
    }
    
    func updateStartup(){
        var startupInfo = Dictionary<String, AnyObject>()
        startupInfo["_id"] = self.startup._id!
        startupInfo["image"] = self.imageTextField.text!

        print("updateStartup: \(startupInfo.description)")
        let url = "https://ff-startups.herokuapp.com/api/startup/"+self.startup._id!
        Alamofire.request(.PUT, url, parameters:startupInfo).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                print("\(json)")
                
            }
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
