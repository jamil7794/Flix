//
//  DetailVC2.swift
//  Flix
//
//  Created by Jamil Jalal on 9/17/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class DetailVC2: UIViewController {

    @IBOutlet weak var backDropImgView: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    var movie: [String: Any]?
    var videos: [[String: Any]] = []
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
        titleLbl.text = movie["title"] as? String
        releaseDateLbl.text = movie["release_date"] as? String
        overviewLbl.text = movie["overview"] as? String
        let backDropPathString = movie["backdrop_path"] as! String
        let posterPathString = movie["poster_path"] as! String
        let baseUrlString = "https://image.tmdb.org/t/p/w500"
        let id = movie["id"] as? Int
      
        let backDropURL = URL(string: baseUrlString + backDropPathString)
        backDropImgView.af_setImage(withURL: backDropURL!)
        
        let posterPathURL = URL(string: baseUrlString + posterPathString)
        imgView.af_setImage(withURL: posterPathURL!)
            
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
        let task = session.dataTask(with: request) { (data, response, error) in
                
        // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                    
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]] //array of dictionary, whole set
                self.videos = movies
            }
                
            }
            
            task.resume()
        }
    
        
        
    }
    @IBAction func posterPressed(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let youtube = segue.destination as! YoutubeVC
        youtube.videos = videos
    }
    
}
