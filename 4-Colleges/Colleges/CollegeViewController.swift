//
//  CollegeViewController.swift
//  Colleges
//
//  Created by Dan Kwon on 6/22/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit
import Alamofire

class CollegeViewController: UIViewController {
    
    var college: College!
    var summaryLabel: UILabel!
    var scrollview: UIScrollView!
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .redColor()
        
        self.scrollview = UIScrollView(frame: frame)
        self.scrollview.backgroundColor = .greenColor()
        self.scrollview.scrollEnabled = true
        view.addSubview(self.scrollview)
        
        // add summary label:
        self.summaryLabel = UILabel(frame: CGRect(x: 20, y: 20, width: frame.size.width-40, height: 22))
        self.summaryLabel.backgroundColor = .blueColor()
        self.summaryLabel.numberOfLines = 0
        self.summaryLabel.lineBreakMode = .ByWordWrapping
        self.scrollview.addSubview(self.summaryLabel)
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("COLLEGE: \(self.college.name)")
        let url = "https://colleges-api.herokuapp.com/api/college/" + college.id
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let collegeInfo = json["college"] as? Dictionary<String, AnyObject>{
                    
                    if let description = collegeInfo["description"] as? String {
                        
                        self.college.summary = description
                        print("\(self.college.summary)")
                        self.summaryLabel.text = self.college.summary
                        
                        var frame = self.summaryLabel.frame
                        let str = NSString(string: self.college.summary!)
                        
                        let bounds = str.boundingRectWithSize(
                            CGSizeMake(frame.size.width, 1200),
                            options: .UsesLineFragmentOrigin,
                            attributes: [NSFontAttributeName:self.summaryLabel.font],
                            context: nil
                        )
                        
                        frame.size.height = bounds.size.height
                        self.summaryLabel.frame = frame
                        self.scrollview.contentSize = CGSizeMake(0, frame.size.height+40)

                        
                    }
                }
            }
        }
        
        


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
