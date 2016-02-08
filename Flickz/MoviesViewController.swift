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
    var searchBar: UISearchBar!
    
    var filteredMovies = [Movie]()
    
    //Table view cell
    let tableCellId:String = "vnu.com.movieOverviewCell"
    let detailSegueId:String = "MovieDetailSegue"
    var searchBtn:UIBarButtonItem!
    var cancelSearchBtn:UIBarButtonItem!
    
    //Grid View Cell
    let gridCellId:String = "com.vnu.moviePosterCell"
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBOutlet weak var switchViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMovieViews()
        setupSearchView()
        setSwitchBtnImage()
        initRefreshControl()
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadMovies()
    }
    
    func initMovieViews(){
        hideErrorView()
        
        //set table and collection datasource and delegates
        moviesTableView.registerNib(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellReuseIdentifier: tableCellId)
        moviesTableView.estimatedRowHeight = 300
        moviesTableView.rowHeight = 200
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self

        
        //Search
        searchBtn = UIBarButtonItem(image: UIImage(named: "search"), style: UIBarButtonItemStyle.Plain, target: self, action: "searchTapped")
        cancelSearchBtn = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelSearch")
        
        currentViewType = listView // Set initial type to list view
        setSwitchBtnImage() // Set the btn image and color
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Load Movie Table
    
    func loadMovies(){
        if let moviesType = moviesType{
            MoviesAPI.sharedInstance.fetchMovies(moviesType, successCallback: updateMovieTable, errorCallback: showErrorView)
        }
    }
    
    func updateMovieTable(fetchedMovies: [Movie]){
        hideErrorView()
        self.movies = fetchedMovies
        filteredMovies = movies
        moviesCollectionView!.reloadData()
        moviesTableView!.reloadData()
        hideProgressBar()
    }
    
    //Loading Bar, Pull to refresh & Error View
    func hideErrorView(){
        errorView.hidden = true
    }
    
    func showErrorView(error: NSError?){
        errorView.hidden = false
        hideProgressBar()
    }
    
    func hideProgressBar(){
        if(initialLoad){
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }else{
            refreshControl.endRefreshing()
        }
    }
    
    func initRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.cyanColor()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        addRefreshSubView()
    }
    
    func addRefreshSubView(){
        isGridView() ? self.moviesCollectionView.insertSubview(refreshControl, atIndex: 0) :
            self.moviesTableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        initialLoad = false
        loadMovies()
    }
    
    //Switch View
    
    func isGridView() -> Bool{
        return currentViewType == gridView
    }
    
    func switchViewImage() -> UIImage{
        return (isGridView() ? UIImage(named: listView)! : UIImage(named: gridView)!)
    }
    
    func setSwitchBtnImage(){
        let tintedImage = switchViewImage().imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        switchViewButton.layer.cornerRadius = 0.5 * switchViewButton.bounds.size.width
        switchViewButton.setImage(tintedImage, forState: .Normal)
        switchViewButton.tintColor = UIColor.yellowColor()
    }
    
    @IBAction func onSwitchViewPressed(sender: UIButton) {
        if isGridView(){
            currentViewType = "listview16"
            moviesCollectionView.hidden = true
            moviesTableView.hidden = false
        }else{
            currentViewType = "gridview16"
            moviesCollectionView.hidden = false
            moviesTableView.hidden = true
        }
        setSwitchBtnImage()
        addRefreshSubView()
    }
    
    //Search Bar
    func setupSearchView(){
        self.navigationItem.rightBarButtonItem = searchBtn
        if let searchBar = searchBar{
            searchBar.text = ""
            updateSearchViewFor(searchBar.text!)
            searchBar.removeFromSuperview()
        }
    }
    
    func searchTapped(){
        self.navigationItem.rightBarButtonItem  = cancelSearchBtn
        searchBar = UISearchBar(frame: CGRectMake(0.0, -80.0, 320.0, 44.0))
        searchBar.delegate = self
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.frame = CGRectMake(0.0, 0, 250, 44)
        searchBar.becomeFirstResponder()
    }
    
    func cancelSearch(){
        setupSearchView()
    }
    
    //Segue into Detail View
    
    //New
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == detailSegueId {
            if let destination = segue.destinationViewController as? MovieDetailViewController {
                if let indexRow = getIndexPath(sender){
                    destination.movie = filteredMovies[indexRow]
                }
                destination.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    func getIndexPath(sender: AnyObject?) -> Int?{
        var index:Int? = nil
        if isGridView(){
            if let cell = sender as? MoviePosterCell{
                let indexPath = self.moviesCollectionView!.indexPathForCell(cell)
                index = indexPath!.row
            }
        }else{
            if let cell = sender as? MovieOverviewCell{
                let indexPath = self.moviesTableView!.indexPathForCell(cell)
                index = indexPath!.row
            }
        }
        return index

    }
    
}


//Grid View

extension MoviesViewController:UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(gridCellId, forIndexPath: indexPath) as! MoviePosterCell
        let movie = filteredMovies[indexPath.item]
        MoviesAPI.sharedInstance.loadPosterImage(movie, posterImage: cell.moviePosterImage)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! MoviePosterCell
        self.performSegueWithIdentifier(detailSegueId, sender: selectedCell)
        cancelSearch()
    }
    
}

extension MoviesViewController:UICollectionViewDelegate{
    
}

extension MoviesViewController:UISearchBarDelegate{
    
    func updateSearchViewFor(searchText: String){
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter({(movie: Movie) -> Bool in
                if movie.title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        self.moviesTableView.reloadData()
        self.moviesCollectionView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        updateSearchViewFor(searchText)
    }
}

//Table View
extension MoviesViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellId, forIndexPath: indexPath) as! MovieOverviewCell
        let movie = filteredMovies[indexPath.row]
        cell.selectionStyle = .None
        cell.movieTitleLabel.text = movie.title
        cell.movieOverviewLabel.text = movie.overview
        MoviesAPI.sharedInstance.loadPosterImage(movie, posterImage: cell.moviePosterImage)
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
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as!MovieOverviewCell
        self.performSegueWithIdentifier(detailSegueId, sender: selectedCell)
        selectedCell.movieTitleLabel.textColor = UIColor.cyanColor()
        cancelSearch()
        
    }
}

extension MoviesViewController: UITableViewDelegate {
}
