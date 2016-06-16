//
//  ImagesViewController.swift
//  MoreViews
//
//  Created by Dan Kwon on 6/8/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var teamLabel: UILabel!
    var imageIndex = 0
    var teamsArray = Array<Dictionary<String, AnyObject>>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueJays = ["name":"Blue Jays", "image":"blueJays.png"]
        self.teamsArray.append(blueJays)
        
        let nationals = ["name":"Nationals", "image":"nats.png"]
        self.teamsArray.append(nationals)

        let yankees = ["name":"Yankees", "image":"yankees.png"]
        self.teamsArray.append(yankees)

        let cardinals = ["name":"Cardinals", "image":"cardinals.png"]
        self.teamsArray.append(cardinals)
    }

    @IBAction func rotateImages(btn: UIButton){
        print("rotateImages: ")
        
        self.imageIndex += 1
        
        let team = self.teamsArray[self.imageIndex % self.teamsArray.count]
        self.teamLabel.text = team["name"] as? String
        
        let imageName = team["image"] as! String
        self.imageView.image = UIImage(named: imageName)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
