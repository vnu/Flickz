//
//  ViewController.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    
    //moviesDB API KEY
    let clientId: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    //Table view cell
    let tableCellId:String = "vnu.com.movieOverviewCell"
    
    let movies = ["Chopped, RealityShow", "Mysteries of Laura, Crime", "Supernatural, Horror", "Padaiyappa, superhit","Pokiri, Action","iZombie, Crime"]
    
    
    @IBOutlet weak var moviesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.registerNib(UINib(nibName: "MovieOverviewCell", bundle: nil), forCellReuseIdentifier: tableCellId)
        moviesTableView.dataSource = self
        moviesTableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MoviesViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellId, forIndexPath: indexPath) as! MovieOverviewCell
        let movie = movies[indexPath.row].componentsSeparatedByString(", ") // Should remove later
        cell.titleLabel.text = movie.first //use proper ones
        cell.overviewLabel.text = movie.last //use proper ones
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
}




