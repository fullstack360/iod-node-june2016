//
//  MovieViewController.swift
//  HomeworkEndofThirdWeekMoviesAPI
//
//  Created by Forrest Filler on 6/25/16.
//  Copyright © 2016 ffdevappsff. All rights reserved.
//

import UIKit
import Alamofire

class MovieViewController: UIViewController {
    
    var movie: Movie!
    var summaryLabel: UILabel!
    
    override func loadView() {
        print("loadView: ")
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .whiteColor()

        let font = UIFont(name: "Arial", size: 16)
        let str = NSString(string: self.movie.overview)
        let bounds = str.boundingRectWithSize(
            CGSizeMake(frame.size.width-40, 1200),
            options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName:font!],
            context: nil
        )
        
        
        self.summaryLabel = UILabel(frame: CGRect(x: 20, y: 84, width: frame.size.width-40, height: bounds.size.height))
//        summaryLabel.backgroundColor = .blueColor()
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .ByWordWrapping
        summaryLabel.font = font
        summaryLabel.text = self.movie.overview
        view.addSubview(self.summaryLabel)
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
