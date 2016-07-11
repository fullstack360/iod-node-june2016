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
    var posts = Array<Post>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 32))
        searchField.autocorrectionType = .No
        searchField.delegate = self
        searchField.backgroundColor = .redColor()
        self.postsTable.tableHeaderView = searchField
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(
            self,
            selector: #selector(ViewController.imageDownloadedNotification(_:)),
            name: "ImageDownloaded",
            object: nil
        )
    }
    
    func imageDownloadedNotification(notification: NSNotification){
        print("imageDownloadedNotification")
        
        self.postsTable.reloadData()
        
    }
    
    func fetchInstagramPosts(username: String){
        let url = "https://www.instagram.com/"+username.lowercaseString+"/media/"
        print("\(url)")
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, AnyObject>{
                if let items = json["items"] as? Array<Dictionary<String, AnyObject>>{
                    print("fetchInstagramPosts: \(items)")
                    
                    for postInfo in items {
                        let post = Post()
                        post.populate(postInfo)
                        self.posts.append(post)
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
            return self.configureCell(cell, indexPath: indexPath)
        }

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        return self.configureCell(cell, indexPath: indexPath)
    }
    
    func configureCell(cell:UITableViewCell, indexPath:NSIndexPath) -> UITableViewCell {
        let post = self.posts[indexPath.row]
        cell.textLabel?.text = post.captionText
        if (post.imageUrl?.characters.count == 0){
            return cell
        }
        
        if (post.image != nil){
            cell.imageView?.image = post.image
            return cell
        }
        
        post.fetchImage()
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

