//
//  CreateStartupViewController.swift
//  startups-ios
//
//  Created by Dan Kwon on 7/27/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import Alamofire

class CreateStartupViewController: UIViewController, UITextFieldDelegate {
    
    var nameTextField: UITextField!
    var founderTextField: UITextField!
    var cityTextField: UITextField!
    var sharesTextField: UITextField!
    var imageTextField: UITextField!    
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .redColor()
        
        var y = CGFloat(120)
        
        let fields = [
            ["placeholder":"Name", "property":"nameTextField"],
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
            
            view.addSubview(field)
            y += field.frame.size.height+20
        }
        
        let btnSubmit = UIButton(type: .Custom)
        btnSubmit.backgroundColor = .blueColor()
        btnSubmit.frame = CGRect(x: 20, y: y, width: frame.size.width-40, height: 44)
        btnSubmit.setTitle("Create", forState: .Normal)
        btnSubmit.setTitleColor(.whiteColor(), forState: .Normal)
        btnSubmit.addTarget(self, action: #selector(CreateStartupViewController.createStartup), forControlEvents: .TouchUpInside)
        view.addSubview(btnSubmit)

        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func createStartup(){
        
        let fields = [
            self.nameTextField,
            self.founderTextField,
            self.cityTextField,
            self.sharesTextField,
            self.imageTextField
        ]
        
        var startupProps = Dictionary<String, AnyObject>() // pkg to server
        var missingValue: String? = nil
        for field in fields {
            let value = field.text!
            let property = field.placeholder?.lowercaseString
            
            if (value.characters.count == 0){
                missingValue = property
                break
            }
            
            startupProps[property!] = field.text!
        }
        
        // if there is a missingValue, do NOT proceed:
        if (missingValue != nil){
            let msg = "Please include a "+missingValue!
            let alert = UIAlertController(
                title: "Missing Value",
                message: msg,
                preferredStyle: .Alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let url = "https://ff-startups.herokuapp.com/api/startup"
        Alamofire.request(.POST, url, parameters: startupProps).responseJSON{ response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let result = json["result"] as? Dictionary<String, AnyObject>{
                    print("createStartup: \(result)")
                    
                    let startup = Startup()
                    startup.populate(result)
                    
                    let notification = NSNotification(
                        name: "StartupCreated",
                        object: nil,
                        userInfo: ["startup":startup]
                    )

                    let notificationCtr = NSNotificationCenter.defaultCenter()
                    notificationCtr.postNotification(notification)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
