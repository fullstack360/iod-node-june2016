//
//  ViewController.swift
//  TableView
//
//  Created by Dan Kwon on 6/15/16.
//  Copyright © 2016 Velocity 360. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var showsTable: UITableView!
    var comediesArray = Array<Show>()
    var dramasArray = Array<Show>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let howIMetYourMother = Show()
        howIMetYourMother.name = "How I Met Your Mother"
        howIMetYourMother.network = "NBC"
        howIMetYourMother.type = "comedy"
        howIMetYourMother.image = "how_i_met_your_mother.png"
        howIMetYourMother.summary = "A father recounts to his children, through a series of flashbacks, the journey he and his four best friends took leading up to him meeting their mother."
        howIMetYourMother.cast.append("josh radnor")
        howIMetYourMother.cast.append("neil patrick harris")
        howIMetYourMother.cast.append("jason segal")
        self.comediesArray.append(howIMetYourMother)
        
        let twoAndAHalfMen = Show()
        twoAndAHalfMen.name = "Two and a Half Men"
        twoAndAHalfMen.type = "comedy"
        twoAndAHalfMen.network = "CBS"
        twoAndAHalfMen.image = "two_and_a_half_men.png"
        twoAndAHalfMen.summary = "A hedonistic jingle writer's free-wheeling life comes to an abrupt halt when his brother and 10-year-old nephew move into his beach-front house."
        twoAndAHalfMen.cast.append("jon cryer")
        twoAndAHalfMen.cast.append("ashton kutcher")
        self.comediesArray.append(twoAndAHalfMen)
        
        let gameOfThrones = Show()
        gameOfThrones.name = "Game of Thrones"
        gameOfThrones.type = "drama"
        gameOfThrones.network = "HBO"
        gameOfThrones.image = "game_of_thrones.png"
        gameOfThrones.summary = "While a civil war brews between several noble families in Westeros, the children of the former rulers of the land attempt to rise up to power. Meanwhile a forgotten race, bent on destruction, plans to return after thousands of years in the North."
        gameOfThrones.cast.append("Emilia Clarke")
        gameOfThrones.cast.append("Peter Dinklage")
        self.dramasArray.append(gameOfThrones)
        
        let modernFamily = Show()
        modernFamily.name = "Modern Family"
        modernFamily.type = "drama"
        modernFamily.network = "ABC"
        modernFamily.image = "modern_family.png"
        modernFamily.summary = "Three different, but related families face trials and tribulations in their own uniquely comedic ways."
        modernFamily.cast.append("Ed O'Neil")
        modernFamily.cast.append("Sofia Vergara")
        self.dramasArray.append(modernFamily)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return self.comediesArray.count
        }
        
        return self.dramasArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellId = "cellId"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId){
            return self.configureCell(cell, indexPath: indexPath)
        }

        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        return self.configureCell(cell, indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var show: Show
        if (indexPath.section == 0){
            show = self.comediesArray[indexPath.row]
        }
        else {
            show = self.dramasArray[indexPath.row]
        }
        
        print("didSelectRowAtIndexPath: \(show.name)")
        let showVc = ShowViewController()
        showVc.show = show
        self.navigationController?.pushViewController(showVc, animated: true)
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        var show: Show
        if (indexPath.section == 0){
            show = self.comediesArray[indexPath.row]
        }
        else {
            show = self.dramasArray[indexPath.row]
        }
        
        
        cell.textLabel?.text = show.name
        cell.detailTextLabel?.text = show.network
        cell.imageView?.image = UIImage(named: show.image)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Comedies"
        }
        
        return "Dramas"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

