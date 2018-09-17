//
//  DetailViewController.swift
//  Flix
//
//  Created by Jamil Jalal on 9/17/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLbl.text = movie["title"] as? String
            releaseDateLbl.text = movie["release_date"] as? String
            overviewLbl.text = movie["overview"] as? String
            let backDropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            
            let backDropURL = URL(string: baseUrlString + backDropPathString)
            backDropImageView.af_setImage(withURL: backDropURL!)
            
            let posterPathURL = URL(string: baseUrlString + posterPathString)
            posterImageView.af_setImage(withURL: posterPathURL!)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
