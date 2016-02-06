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

class Movie {

    // MARK: Properties
    
    var posterPath: String
    var adult: Bool
    var overview: String
    var releaseDate: String
    var genreId: Array<Int>
    var ID: Int32
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String
    var popularity: Double
    var voteCount: Int16
    var video: Bool
    var voteAverage: Double
    

    // MARK: Initialization

    init(posterPath: String, adult: Bool, overview: String, releaseDate: String, genreId: Array<Int>, ID: Int32, originalTitle: String, originalLanguage: String, title: String, backdropPath: String, popularity: Double, voteCount: Int16, video: Bool, voteAverage: Double) {
         // Initialize stored properties.
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreId = genreId
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

}

