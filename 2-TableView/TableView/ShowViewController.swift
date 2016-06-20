//
//  ShowViewController.swift
//  TableView
//
//  Created by Dan Kwon on 6/15/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    var show: Show!
    
    override func loadView() {
        self.edgesForExtendedLayout = .None
        self.title = self.show.name
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .darkGrayColor()
        
        let showBackdrop = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.height))
        showBackdrop.image = UIImage(named: self.show.image)
        view.addSubview(showBackdrop)
        
        let darkScreen = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        darkScreen.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.addSubview(darkScreen)
        
        let showImage = UIImageView(frame: CGRect(x: 0, y: 60, width: 160, height: 160))
        showImage.center = CGPointMake(0.5*frame.size.width, showImage.center.y)
        showImage.layer.cornerRadius = 0.5*showImage.frame.size.height
        showImage.layer.masksToBounds = true
        showImage.layer.borderColor = UIColor.whiteColor().CGColor
        showImage.layer.borderWidth = 2
        showImage.image = UIImage(named: self.show.image)
        view.addSubview(showImage)
        
        let padding = CGFloat(20)
        let width = frame.size.width-2*padding
        
        let font = UIFont(name: "Arial", size: 16)
        let str = NSString(string: self.show.summary)
        var bounds = str.boundingRectWithSize(
            CGSizeMake(width, 500),
            options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName:font!],
            context: nil)
        bounds.origin.x = padding
        bounds.origin.y = 240
        
        
        let summaryLabel = UILabel(frame: bounds)
        summaryLabel.font = font
        summaryLabel.backgroundColor = .clearColor()
        summaryLabel.numberOfLines = 0 // unlimited number of lines
        summaryLabel.lineBreakMode = .ByWordWrapping
        summaryLabel.textAlignment = .Center
        summaryLabel.textColor = .whiteColor()
        summaryLabel.text = self.show.summary
        view.addSubview(summaryLabel)
        
        var y = summaryLabel.frame.origin.y+summaryLabel.frame.size.height+padding
        let lblCast = UILabel(frame: CGRect(x: padding, y: y, width: width, height: 22))
        lblCast.textAlignment = .Center
        lblCast.textColor = .whiteColor()
        lblCast.font = UIFont.boldSystemFontOfSize(18)
        lblCast.text = "Cast"
        view.addSubview(lblCast)
        y += lblCast.frame.size.height
        
        
        
        
        var castString = ""
        for castMember in self.show.cast {
            castString += castMember
            let index = self.show.cast.indexOf(castMember)
            if (index != self.show.cast.count-1){
                castString += ", "
            }
        }
        
        let castStr = NSString(string: castString)
        let castBounds = castStr.boundingRectWithSize(
            CGSizeMake(width, 500),
            options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName:font!],
            context: nil)

        let lblCastMembers = UILabel(frame: CGRect(x: padding, y: y, width: width, height: castBounds.size.height))
        view.addSubview(lblCastMembers)

        print("CAST: \(castString)")
        lblCastMembers.text = castString
        lblCastMembers.numberOfLines = 0
        lblCastMembers.lineBreakMode = .ByWordWrapping
        lblCastMembers.textColor = .whiteColor()
        lblCastMembers.textAlignment = .Center
        lblCastMembers.font = font
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
