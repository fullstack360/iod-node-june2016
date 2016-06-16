//
//  ScrollViewController.swift
//  MoreViews
//
//  Created by Dan Kwon on 6/8/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var imagesScrollView: UIScrollView!
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var textField: UITextField!
    var teamsArray = Array<Dictionary<String, AnyObject>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesScrollView.showsHorizontalScrollIndicator = false
        self.imagesScrollView.pagingEnabled = true
        self.imagesScrollView.delegate = self

        let blueJays = ["name":"Blue Jays", "image":"blueJays.png"]
        self.teamsArray.append(blueJays)
        let blueJaysLogo = UIImageView(image: UIImage(named:"blueJays.png"))
        blueJaysLogo.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.imagesScrollView.addSubview(blueJaysLogo)
        
        
        let nationals = ["name":"Nationals", "image":"nats.png"]
        self.teamsArray.append(nationals)
        let nationalsLogo = UIImageView(image: UIImage(named:"nats.png"))
        nationalsLogo.frame = CGRect(x: 200, y: 0, width: 200, height: 200)
        self.imagesScrollView.addSubview(nationalsLogo)
        
        
        let yankees = ["name":"Yankees", "image":"yankees.png"]
        self.teamsArray.append(yankees)
        let yankeesLogo = UIImageView(image: UIImage(named:"yankees.png"))
        yankeesLogo.frame = CGRect(x: 400, y: 0, width: 200, height: 200)
        self.imagesScrollView.addSubview(yankeesLogo)
        
        
        let cardinals = ["name":"Cardinals", "image":"cardinals.png"]
        self.teamsArray.append(cardinals)
        let cardinalsLogo = UIImageView(image: UIImage(named:"cardinals.png"))
        cardinalsLogo.frame = CGRect(x: 600, y: 0, width: 200, height: 200)
        self.imagesScrollView.addSubview(cardinalsLogo)

        self.imagesScrollView.contentSize = CGSizeMake(800, 0)
        
        self.pageControl.numberOfPages = self.teamsArray.count
        self.textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollViewDidScroll: \(scrollView.contentOffset.x)")
        
        if (scrollView.contentOffset.x < 100){
            self.pageControl.currentPage = 0
            self.teamLabel.text = "Blue Jays"
        }
        else if (scrollView.contentOffset.x < 300){
            self.pageControl.currentPage = 1
            self.teamLabel.text = "Nationals"
        }
        else if (scrollView.contentOffset.x < 500){
            self.pageControl.currentPage = 2
            self.teamLabel.text = "Yankees"
        }
        else {
            self.pageControl.currentPage = 3
            self.teamLabel.text = "Cardinals"
        }
        
        
    }
    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
//        print("scrollViewDidEndDecelerating: \(scrollView.contentOffset.x)")
//        
//        if (scrollView.contentOffset.x == 0){
//            self.teamLabel.text = "Blue Jays"
//            self.pageControl.currentPage = 0
//        }
//        if (scrollView.contentOffset.x == 200){
//            self.teamLabel.text = "Nationals"
//            self.pageControl.currentPage = 1
//        }
//        if (scrollView.contentOffset.x == 400){
//            self.teamLabel.text = "Yankees"
//            self.pageControl.currentPage = 2
//        }
//        if (scrollView.contentOffset.x == 600){
//            self.teamLabel.text = "Cardinals"
//            self.pageControl.currentPage = 3
//        }
//    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let lowerCaseString = string.lowercaseString
        print("shouldChangeCharactersInRange: \(string)")
        if (lowerCaseString == "a"){
            self.view.backgroundColor = .redColor()
        }
        else if (lowerCaseString == "e"){
            self.view.backgroundColor = .redColor()
        }
        else if (lowerCaseString == "i"){
            self.view.backgroundColor = .redColor()
        }
        else if (lowerCaseString == "o"){
            self.view.backgroundColor = .redColor()
        }
        else if (lowerCaseString == "u"){
            self.view.backgroundColor = .redColor()
        }
        else {
            self.view.backgroundColor = .lightGrayColor()
        }
        
        
        return true
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
