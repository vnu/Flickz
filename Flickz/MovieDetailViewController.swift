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
    @IBOutlet weak var movieDetailScrollView: UIScrollView!
    
    @IBOutlet weak var movieDetailPosterImage: UIImageView!

    @IBOutlet weak var movieDescriptionView: UIView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentSize()
        setMovieDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setMovieDetails(){
        self.title = movie.title
        self.movieNameLabel.text = movie.title
        self.movieReleaseLabel.text = movie.movieReleaseDate()
        self.movieOverviewLabel.text = movie.overview
        self.movieOverviewLabel.sizeToFit()
        self.movieRatingLabel.text = "\(String(format:"%.1f", movie.voteAverage))"
        loadPosterImage()
    }

    func setContentSize(){
        let contentWidth = movieDetailScrollView.bounds.width
        let contentHeight = movieDetailScrollView.bounds.height + movieOverviewLabel.frame.height
        movieDetailScrollView.contentSize = CGSizeMake(contentWidth, contentHeight)
    }
    
    //TODO: Refactor this and move the fetch logic to HTTPClient
    func loadPosterImage(){
        if let lowPosterURL = self.movie.lowResPosterURL(){
            let lowResPosterURLRequest = NSURLRequest(URL: lowPosterURL)
            self.movieDetailPosterImage.setImageWithURLRequest(lowResPosterURLRequest, placeholderImage: nil,
                success: {(lowResPosterURLRequest, lowResPosterURLResponse, lowResPosterImage) -> Void in
                    self.movieDetailPosterImage.alpha = 0.0
                    self.movieDetailPosterImage.image = lowResPosterImage
                    
                    UIView.animateWithDuration(0.3, animations: {() -> Void in
                        self.movieDetailPosterImage.alpha = 1.0
                        }, completion: {(success) -> Void in
                            if let highPosterURL = self.movie.highResPosterURL(){
                            let highResPosterURLRequest = NSURLRequest(URL: highPosterURL)
                            self.movieDetailPosterImage.setImageWithURLRequest(highResPosterURLRequest, placeholderImage: nil,
                                success: {(highResPosterURLRequest, highResPosterURLResponse, highResPosterImage) -> Void in
                                    self.movieDetailPosterImage.image = highResPosterImage;
                                }, failure: { (highResPosterURLRequest, highResPosterURLResponse, error) -> Void in
                                    NSLog("High Res Image Request failed")
                            })
                        }
                    })
                    
                }, failure: { (lowResPosterURLRequest, lowResPosterURLResponse, error) -> Void in
                    NSLog("Low Res Image Request failed")
            })
        }
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
