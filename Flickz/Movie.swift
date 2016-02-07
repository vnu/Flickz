//
//  Movie.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit


/* Sample Data
{
poster_path: "/k1QUCjNAkfRpWfm1dVJGUmVHzGv.jpg",
adult: false,
overview: "Based upon Marvel Comics’ most unconventional anti-hero, DEADPOOL tells the origin story of former Special Forces operative turned mercenary Wade Wilson, who after being subjected to a rogue experiment that leaves him with accelerated healing powers, adopts the alter ego Deadpool. Armed with his new abilities and a dark, twisted sense of humor, Deadpool hunts down the man who nearly destroyed his life.",
release_date: "2016-02-09",
genre_ids: [
35,
12,
28,
878
],
id: 293660,
original_title: "Deadpool",
original_language: "en",
title: "Deadpool",
backdrop_path: "/n1y094tVDFATSzkTnFxoGZ1qNsG.jpg",
popularity: 20.322214,
vote_count: 131,
video: false,
vote_average: 6.05
}
*/

import Foundation
import UIKit

class Movie {

    // MARK: Properties
    
    var posterPath: String?
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreIds: Array<Int>
    var ID: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String?
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAverage: Double
    

    // MARK: Initialization

    init(posterPath: String, adult: Bool, overview: String, releaseDate: String, genreIds: Array<Int>, ID: Int, originalTitle: String, originalLanguage: String, title: String, backdropPath: String, popularity: Double, voteCount: Int, video: Bool, voteAverage: Double) {
         // Initialize stored properties.
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.ID = ID
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
    
    init(jsonResult: NSDictionary) {
        // Initialize stored properties.
        self.posterPath = jsonResult["poster_path"] as? String
        self.adult = jsonResult["adult"] as! Bool
        self.overview = jsonResult["overview"] as! String
        self.releaseDate = jsonResult["release_date"] as! String
        self.genreIds = jsonResult["genre_ids"] as! Array<Int>
        self.ID = jsonResult["id"] as! Int
        self.originalTitle = jsonResult["original_title"] as! String
        self.originalLanguage = jsonResult["original_language"] as! String
        self.title = jsonResult["title"] as! String
        self.backdropPath = jsonResult["backdrop_path"] as? String
        self.popularity = jsonResult["popularity"] as! Double
        self.voteCount = jsonResult["vote_count"] as! Int
        self.video = jsonResult["video"] as! Bool
        self.voteAverage = jsonResult["vote_average"] as! Double
    }
    
    func lowResPosterURL() -> NSURL?{
        let baseUrl = "https://image.tmdb.org/t/p/w92"
        if let posterPath = self.posterPath{
            return NSURL(string:"\(baseUrl)\(posterPath)")!
        }
        return nil
    }
    
    func highResPosterURL() -> NSURL?{
        let baseUrl = "https://image.tmdb.org/t/p/original"
        if let posterPath = self.posterPath{
            return NSURL(string:"\(baseUrl)\(posterPath)")!
        }
        return nil
    }
    
    func movieReleaseDate() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let movieDate = dateFormatter.dateFromString(self.releaseDate) {
            dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
            return dateFormatter.stringFromDate(movieDate)
        }
        return "--"
    }
   

}

