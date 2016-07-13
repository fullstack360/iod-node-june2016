//
//  ISImageDetailViewController.swift
//  ImageSelector
//
//  Created by Dan Kwon on 7/11/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit

class ISImageDetailViewController: UIViewController, UITextFieldDelegate {
    
    var selectedImage: ISImage!
    var captionField: UITextField!
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame:frame)
        view.backgroundColor = .redColor()
        
        let width = frame.size.width
        let scale = width/self.selectedImage.image!.size.width
        let height = scale*self.selectedImage.image!.size.height
        
        var y = CGFloat(84)
        self.captionField = UITextField(frame: CGRect(x: 20, y: y, width: frame.size.width-40, height: 32))
        self.captionField.delegate = self
        self.captionField.borderStyle = .RoundedRect
        view.addSubview(self.captionField)
        y += self.captionField.frame.size.height+20
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: y, width: width, height: height))
        imageView.image = self.selectedImage.image
        view.addSubview(imageView)
        y += imageView.frame.size.height+20
        
        let btnSubmit = UIButton(type: .Custom)
        btnSubmit.frame = CGRect(x: 20, y: y, width: frame.size.width-40, height: 44)
        btnSubmit.backgroundColor = UIColor(red: 0.65, green: 0.72, blue: 0.8, alpha: 1)
        btnSubmit.setTitle("Submit", forState: .Normal)
        btnSubmit.layer.borderColor = UIColor.lightGrayColor().CGColor
        btnSubmit.layer.cornerRadius = 0.5*btnSubmit.frame.size.height
        btnSubmit.setTitleColor(.grayColor(), forState: .Normal)
        btnSubmit.setTitleColor(.redColor(), forState: .Highlighted)
        btnSubmit.addTarget(
            self,
            action: #selector(ISImageDetailViewController.assignImageCaption),
            forControlEvents: .TouchUpInside
        )
        
        view.addSubview(btnSubmit)
        
        self.view = view
    }
    
    func assignImageCaption(){
        print("assignImageCaption: \(self.captionField.text)")
        
        self.selectedImage.caption = self.captionField.text!
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.selectedImage.caption = textField.text!
        print("textFieldShouldReturn: \(self.selectedImage.caption)")
        self.navigationController?.popViewControllerAnimated(true)
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
