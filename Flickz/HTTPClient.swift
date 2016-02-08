//
//  HTTPClient.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/6/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit
import AFNetworking

class HTTPClient {
    
    //moviesDB API KEY
    static let apiKey: String = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let baseUrl = "https://api.themoviedb.org/3/movie/"
    
    private let params = ["api_key": apiKey]
    
    
    func buildUrl(fetchType: String) -> String{
        return "\(baseUrl)\(fetchType)?api_key=\(HTTPClient.apiKey)"
    }
    
    //Fetch using AFNetworking 3.0 AFHTTPSessionManager
    func fetch(resourceUrl:String, successCallback: ([Movie]) -> Void, error: ((NSError?) -> Void)?) {
        let manager = AFHTTPSessionManager();
        //TODO: Figure out what progress is
        manager.GET(resourceUrl, parameters: params, progress: nil, success: { (operation ,responseObject) -> Void in
            if let results = responseObject!["results"] as? NSArray {
                var movies: [Movie] = []
                for result in results as! [NSDictionary] {
                    movies.append(Movie(jsonResult: result))
                }
                successCallback(movies)
            }
            }, failure: { (operation, requestError) -> Void in
                if let errorCallback = error {
                    errorCallback(requestError)
                }
        })
        
    }
    
    //Fetch using NSURL SESSION (Not used. Keeping here for reference)
    func fetchNSURLSession(fetchUrl: String){
        let url = NSURL(string: fetchUrl)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                    }
                }
        });
        task.resume()
    }
    
    
    //TODO: Refactor this and move the fetch logic to HTTPClient
    func fetchPosterImage(movie: Movie, movieDetailPosterImage: UIImageView){
        if let lowPosterURL = movie.lowResPosterURL(){
            let lowResPosterURLRequest = NSURLRequest(URL: lowPosterURL)
            movieDetailPosterImage.setImageWithURLRequest(lowResPosterURLRequest, placeholderImage: nil,
                success: {(lowResPosterURLRequest, lowResPosterURLResponse, lowResPosterImage) -> Void in
                    movieDetailPosterImage.alpha = 0.0
                    movieDetailPosterImage.image = lowResPosterImage
                    
                    UIView.animateWithDuration(0.3, animations: {() -> Void in
                        movieDetailPosterImage.alpha = 1.0
                        }, completion: {(success) -> Void in
                            if let highPosterURL = movie.highResPosterURL(){
                                let highResPosterURLRequest = NSURLRequest(URL: highPosterURL)
                                movieDetailPosterImage.setImageWithURLRequest(highResPosterURLRequest, placeholderImage: nil,
                                    success: {(highResPosterURLRequest, highResPosterURLResponse, highResPosterImage) -> Void in
                                        movieDetailPosterImage.image = highResPosterImage;
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

    
    //Fetch Image
    
}