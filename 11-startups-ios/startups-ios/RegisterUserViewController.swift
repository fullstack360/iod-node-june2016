//
//  RegisterUserViewController.swift
//  startups-ios
//
//  Created by Forrest Filler on 8/1/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import Alamofire

class RegisterUserViewController: UIViewController, UITextFieldDelegate {
    
    var firstnameTxtFld: UITextField!
    var lastnameTxtFld: UITextField!
    var emailTxtFld: UITextField!
    var passwordTxtFld: UITextField!
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .redColor()
        
        var y = CGFloat(120)
        
        let fields = [
            ["placeholder":"First Name", "property":"firstnameTxtFld"],
            ["placeholder":"Last Name", "property":"lastnameTxtFld"],
            ["placeholder":"Email", "property":"emailTxtFld"],
            ["placeholder":"Password", "property":"passwordTxtFld"]
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
        btnSubmit.addTarget(self, action: #selector(RegisterUserViewController.createProfile), forControlEvents: .TouchUpInside)
        view.addSubview(btnSubmit)
        self.view = view
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        print("textFieldShouldReturn: ")
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Profile"
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Cancel,
            target: self,
            action: #selector(RegisterUserViewController.cancelAndDismissThisVC)
        )
    }
    
    func cancelAndDismissThisVC() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createProfile() {
        //print("createProfile: ")
        let fields = [
            self.firstnameTxtFld,
            self.lastnameTxtFld,
            self.emailTxtFld,
            self.passwordTxtFld
        ]
        
        var profileProps = Dictionary<String, AnyObject>()
        for field in fields{
            let property = field.placeholder?.lowercaseString
            let formattedProperty = property!.stringByReplacingOccurrencesOfString(" ", withString: "")
            profileProps[formattedProperty] = field.text!
        }
        
        let url = "https://ff-startups.herokuapp.com/api/profile/"
        Alamofire.request(.POST, url, parameters: profileProps).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                //print("the JSON Step 1: \(json)")
                if let result = json["result"] as? Dictionary<String, AnyObject>{
                    print("the result is: \(result)")
                    
                    let profile = Profile()
                    profile.populate(result)
                    
                    let notification = NSNotification(
                        name: "ProfileCreated",
                        object: nil,
                        userInfo:  nil
                    )
                    
                    let notificationCtr = NSNotificationCenter.defaultCenter()
                    notificationCtr.postNotification(notification)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
//                    let Vc = ViewController()
//                    self.presentViewController(Vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}