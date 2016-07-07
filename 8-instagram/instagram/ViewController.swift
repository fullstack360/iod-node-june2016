//
//  ViewController.swift
//  instagram
//
//  Created by Dan Kwon on 7/6/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var postsTable: UITableView!
    var posts = Array<Dictionary<String, AnyObject>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 32))
        searchField.delegate = self
        searchField.backgroundColor = .redColor()
        self.postsTable.tableHeaderView = searchField
    }
    
    func fetchInstagramPosts(username: String){
        
        
        let url = "https://www.instagram.com/"+username.lowercaseString+"/media/"
        print("\(url)")
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let items = json["items"] as? Array<Dictionary<String, AnyObject>>{
                    print("fetchInstagramPosts: \(items)")
                    
                    for postInfo in items {
                        self.posts.append(postInfo)
                    }
                    
                    self.postsTable.reloadData()
                    
                }
                
            }
            
        }
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        print("textFieldShouldReturn: \(textField.text!)")
        
        self.fetchInstagramPosts(textField.text!)
        
        
        
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = self.posts[indexPath.row]
        let caption = post["caption"] as? Dictionary<String, AnyObject>
        
        
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
            cell.textLabel?.text = caption!["text"] as? String
            return cell
        }

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = caption!["text"] as? String
        return cell

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

