//
//  ViewController.swift
//  Colleges
//
//  Created by Dan Kwon on 6/20/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var collegesTable: UITableView!
    var collegeList = Array<College>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://colleges-api.herokuapp.com/api/college"
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                print("\(json)")
                
                if let colleges = json["colleges"] as? Array<Dictionary<String, AnyObject>> {
                    
                    for collegeInfo in colleges {
                        let college = College()
                        college.populate(collegeInfo)
                        self.collegeList.append(college)
                    }
                    
                    self.collegesTable.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collegeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let college = self.collegeList[indexPath.row]
        
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            cell.textLabel?.text = college.name
            cell.detailTextLabel?.text = college.location+", "+college.mascot
            return cell
        }
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = college.name
        cell.detailTextLabel?.text = college.location+", "+college.mascot
        return cell
    }
}

