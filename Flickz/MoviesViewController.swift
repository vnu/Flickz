//
//  ViewController.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController {
    
    
    //Table view cell
    let tableCellId:String = "vnu.com.movieOverviewCell"
    let detailSegueId:String = "MovieDetailSegue"
    
    private var movies = [Movie]()
    
    @IBOutlet weak var moviesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.registerNib(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellReuseIdentifier: tableCellId)
        moviesTableView.estimatedRowHeight = 500
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        MoviesAPI.sharedInstance.fetchNowPlayingMovies(reloadMovieTable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reloadMovieTable(fetchedMovies: [Movie]){
        self.movies = fetchedMovies
        moviesTableView!.reloadData()
    }
    
}

extension MoviesViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellId, forIndexPath: indexPath) as! MovieOverviewCell
        let movie = movies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        cell.movieOverviewLabel.text = movie.overview
        if let posterURL = movie.lowResPosterURL(){
            cell.moviePosterImage.setImageWithURL(posterURL)
        }

        return cell
    }

    //New
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegueId {
            if let destination = segue.destinationViewController as? MovieDetailViewController {
                if let indexPath = self.moviesTableView.indexPathForSelectedRow{
                    destination.movie = movies[indexPath.row]
                }
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(detailSegueId, sender: self)
    }
}

extension MoviesViewController: UITableViewDelegate {
}




