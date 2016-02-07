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
    
    
    private var movies = [Movie]()
    var refreshControl:UIRefreshControl!
    var initialLoad:Bool = true
    var moviesType:String!
    
    let gridView = "gridview16"
    let listView = "listview16"
    
    var currentViewType:String!
    
    
    //Table view cell
    let tableCellId:String = "vnu.com.movieOverviewCell"
    let detailSegueId:String = "MovieDetailSegue"
    
    //Grid View Cell
    let gridCellId:String = "com.vnu.moviePosterCell"
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrorView()
        initMovieViews()
        setupSwitchView()
        initRefreshControl()
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadMovies()
    }
    
    func setupSwitchView(){
        currentViewType = listView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: barItemImage(), style: UIBarButtonItemStyle.Plain, target: self, action: "switchViewTapped")
    }
    
    func isGridView() -> Bool{
        return currentViewType == gridView
    }
    
    func isListView() -> Bool{
        return currentViewType == listView
    }
    
    func barItemImage() -> UIImage{
        return (isGridView() ? UIImage(named: listView)! : UIImage(named: gridView)!)
    }
    
    func switchViewTapped(){
        if isGridView(){
            currentViewType = "listview16"
            moviesCollectionView.hidden = true
            moviesTableView.hidden = false
        }else{
            currentViewType = "gridview16"
            moviesCollectionView.hidden = false
            moviesTableView.hidden = true
        }
        self.navigationItem.rightBarButtonItem?.image = barItemImage()
    }
    
    func initMovieViews(){
        moviesTableView.registerNib(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellReuseIdentifier: tableCellId)
        moviesTableView.estimatedRowHeight = 200
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
    func initRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.cyanColor()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        self.moviesTableView.insertSubview(refreshControl, atIndex: 0)
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
        if let moviesType = moviesType{
            MoviesAPI.sharedInstance.fetchMovies(moviesType, successCallback: updateMovieTable, errorCallback: showErrorView)
        }
    }
    
    //Callback view after Network success
    func updateMovieTable(fetchedMovies: [Movie]){
        hideErrorView()
        self.movies = fetchedMovies
        moviesCollectionView!.reloadData()
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
    
    //New
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegueId {
            if let destination = segue.destinationViewController as? MovieDetailViewController {
                if let indexPath = self.moviesTableView.indexPathForSelectedRow{
                    destination.movie = movies[indexPath.row]
                    self.moviesTableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
                destination.hidesBottomBarWhenPushed = true
            }
        }
    }
    
}


//Grid View

extension MoviesViewController:UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(gridCellId, forIndexPath: indexPath) as! MoviePosterCell
        let movie = movies[indexPath.item]
        if let posterURL = movie.lowResPosterURL(){
            cell.moviePosterImage.setImageWithURL(posterURL)
        }
        return cell
    }
    
}

extension MoviesViewController:UICollectionViewDelegate{
    
}

//Table View
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
