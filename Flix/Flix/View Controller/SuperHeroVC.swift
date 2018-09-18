//
//  SuperHeroVC.swift
//  Flix
//
//  Created by Jamil Jalal on 9/17/18.
//  Copyright © 2018 Jamil Jalal. All rights reserved.
//

import UIKit

class SuperHeroVC: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SuperHeroVC.didPulltoRefresh), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        fetchMovies()
    }
    @objc func didPulltoRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        
        if let posterPathString = movie["poster_path"] as? String {
            let baseUrlString = "https://image.tmdb.org/t/p/w500"
            let postURL = URL(string: baseUrlString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: postURL)
        }
        return cell
    }
    
    func fetchMovies(){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")! // similarity of wonderwomen
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                
            }else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]] //array of dictionary, whole set
                self.movies = movies
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                //self.activityIndicator.stopAnimating()
            }
            
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController2 = segue.destination as! DetailVC2
            detailViewController2.movie = movie
        }
    }

}
