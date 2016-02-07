//
//  ViewController.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MoviesViewController: UIViewController {
    
    
    //Table view cell
    let tableCellId:String = "vnu.com.movieOverviewCell"
    let detailSegueId:String = "MovieDetailSegue"
    
    @IBOutlet weak var errorView: UIView!
    private var movies = [Movie]()
    var refreshControl:UIRefreshControl!
    var initialLoad:Bool = true
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrorView()
        initMovieTable()
        loadMovies()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.moviesTableView.insertSubview(refreshControl, atIndex: 0)
    }

    func initMovieTable(){
        moviesTableView.registerNib(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellReuseIdentifier: tableCellId)
        moviesTableView.estimatedRowHeight = 200
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func hideErrorView(){
        errorView.hidden = true
    }
    
    func showErrorView(error: NSError?){
        errorView.hidden = false
        hideProgressBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadMovies(){
        MoviesAPI.sharedInstance.fetchNowPlayingMovies(updateMovieTable, errorCallback: showErrorView)
    }
    
    func updateMovieTable(fetchedMovies: [Movie]){
        hideErrorView()
        self.movies = fetchedMovies
        moviesTableView!.reloadData()
        hideProgressBar()
    }
    
    func hideProgressBar(){
        if(initialLoad){
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }else{
            refreshControl.endRefreshing()
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        initialLoad = false
        loadMovies()
    }
    
}

extension MoviesViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellId, forIndexPath: indexPath) as! MovieOverviewCell
        let movie = movies[indexPath.row]
        cell.selectionStyle = .None
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
                    self.moviesTableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as!MovieOverviewCell
        selectedCell.movieTitleLabel.textColor = UIColor.yellowColor()
    }
    
    func tableView(tableView: UITableView, didUnHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as!MovieOverviewCell
        selectedCell.movieTitleLabel.textColor = UIColor.cyanColor()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(detailSegueId, sender: self)
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as!MovieOverviewCell
        selectedCell.movieTitleLabel.textColor = UIColor.cyanColor()
    }
}

extension MoviesViewController: UITableViewDelegate {
}




