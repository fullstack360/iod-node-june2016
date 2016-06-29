//
//  ViewController.swift
//  HomeworkEndofThirdWeekMoviesAPI
//
//  Created by Forrest Filler on 6/25/16.
//  Copyright © 2016 ffdevappsff. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var moviesTable: UITableView!
    var movieList = Array<Movie>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=98b525225a2fe71d855108eca4fdf12d/" //put a '/' at end of link
        let url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=98b525225a2fe71d855108eca4fdf12d" //put a '/' at end of link
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
         
            if let json = response.result.value as? Dictionary<String, AnyObject> {
                print("json")
                
//                if let movies = json["movies"] as? Array<Dictionary<String, AnyObject>>{
                if let movies = json["results"] as? Array<Dictionary<String, AnyObject>>{
                    
                    for movieInfo in movies {
                        let movie = Movie()
                        movie.populate(movieInfo)
                        self.movieList.append(movie)
                    }
                    
                    self.moviesTable.reloadData()
                }
                
            }
            
        }
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.movieList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = self.movieList[indexPath.row]
        
        let cellId = "cellId"
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellId) {
            cell.textLabel?.text =  movie.title
            cell.detailTextLabel?.text = "Vote Avg: \(movie.vote_average)"
            return cell
        }
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = "Vote Avg: \(movie.vote_average)"
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let movie = self.movieList[indexPath.row]
        let movieVc = MovieViewController()
        movieVc.movie = movie
        self.navigationController?.pushViewController(movieVc, animated: true)
    }

}

