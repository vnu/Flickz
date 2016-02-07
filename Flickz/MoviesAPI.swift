//
//  MoviesAPI.swift
//  Flickz
//
//  Created by Vinu Charanya on 2/5/16.
//  Copyright © 2016 vnu. All rights reserved.
//

import UIKit

class MoviesAPI {
    
    //Singleton Class
    static let sharedInstance = MoviesAPI()
    
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    init() {
        httpClient = HTTPClient()
        isOnline = false
    }
    
    func fetchMovies(moviesType: String, successCallback: ([Movie]) -> Void, errorCallback: (NSError?) -> Void){
        let url = httpClient.buildUrl(moviesType)
        httpClient.fetch(url, successCallback: successCallback, error: errorCallback)
    }
    
    func fetchNowPlayingMovies(successCallback: ([Movie]) -> Void, errorCallback: (NSError?) -> Void){
        let url = httpClient.buildUrl("now_playing")
        httpClient.fetch(url, successCallback: successCallback, error: errorCallback)
    }
    
    func fetchTopRatedMovies(successCallback: ([Movie]) -> Void, errorCallback: (NSError?) -> Void){
        let url = httpClient.buildUrl("top_rated")
        httpClient.fetch(url, successCallback: successCallback, error: errorCallback)
    }
    
    func fetchUpcomingMovies(successCallback: ([Movie]) -> Void, errorCallback: (NSError?) -> Void){
        let url = httpClient.buildUrl("upcoming")
        httpClient.fetch(url, successCallback: successCallback, error: errorCallback)
    }
    
    func fetchPopularMovies(successCallback: ([Movie]) -> Void, errorCallback: (NSError?) -> Void){
        let url = httpClient.buildUrl("popular")
        httpClient.fetch(url, successCallback: successCallback, error: errorCallback)
    }

    
}