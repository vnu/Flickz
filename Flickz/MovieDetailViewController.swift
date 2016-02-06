//
//  MovieDetailViewController.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/6/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie:Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
