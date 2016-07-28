//
//  StartupViewController.swift
//  startups-ios
//
//  Created by Dan Kwon on 7/25/16.
//  Copyright © 2016 Velocity360. All rights reserved.


import UIKit
import Alamofire

class StartupViewController: UIViewController, UITextFieldDelegate {
    
    var startup: Startup!
    var startupImage: UIImageView!
    var founderTextField: UITextField!
    var cityTextField: UITextField!
    var sharesTextField: UITextField!
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
        
        let fields = [
            ["placeholder":"Founder", "property":"founderTextField"],
            ["placeholder":"City", "property":"cityTextField"],
            ["placeholder":"Shares", "property":"sharesTextField"],
            ["placeholder":"Image", "property":"imageTextField"]
        ]
        
        for i in 0..<fields.count {
            let fieldInfo = fields[i]
            let field = UITextField(frame: CGRect(x: 20, y: y, width: frame.size.width-40, height: 32))
            field.delegate = self
            field.placeholder = fieldInfo["placeholder"]
            let prop = fieldInfo["property"]
            self.setValue(field, forKey: prop!)
            
            field.borderStyle = .RoundedRect
            field.autocapitalizationType = .None
            field.autocorrectionType = .No
            
            let propertyName = field.placeholder?.lowercaseString
            if (propertyName == "shares"){
                field.text = String(self.startup.shares!)
            }
            else {
                field.text = self.startup.valueForKeyPath(propertyName!) as? String
            }
            
            view.addSubview(field)
            y += field.frame.size.height+20
        }
        
        
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn: ")
        self.updateStartup()
        return true
    }
    
    func updateStartup(){
        var startupInfo = Dictionary<String, AnyObject>()
        startupInfo["_id"] = self.startup._id!
        startupInfo["city"] = self.cityTextField.text!
        startupInfo["founder"] = self.founderTextField.text!
        startupInfo["shares"] = self.sharesTextField.text!
        
        let img = self.imageTextField.text!
        if (img != self.startup.image){ // user selected new image
            self.startup.imageData = nil
            startupInfo["image"] = img
        }

        print("updateStartup: \(startupInfo.description)")
        let url = "https://ff-startups.herokuapp.com/api/startup/"+self.startup._id!
        Alamofire.request(.PUT, url, parameters:startupInfo).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                
                if let result = json["result"] as? Dictionary<String, AnyObject>{
                    print("\(result)")
                    
                    self.startup.populate(result)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
