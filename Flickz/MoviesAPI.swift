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
    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
    }
    
    func getMovies() -> [Movie] {
        return [] //persistencyManager.getAlbums()
    }
    
    func fetchNowPlayingMovies(successCallback: ([Movie]) -> Void){
        let url = httpClient.buildUrl("now_playing")
        httpClient.fetch(url, successCallback: successCallback, error: nil)
    }
    
    func fetchTopRatedMovies(successCallback: ([Movie]) -> Void){
        let url = httpClient.buildUrl("top_rated")
        httpClient.fetch(url, successCallback: successCallback, error: nil)
    }
    
    func fetchUpcomingMovies(successCallback: ([Movie]) -> Void){
        let url = httpClient.buildUrl("upcoming")
        httpClient.fetch(url, successCallback: successCallback, error: nil)
    }
    
    func fetchPopularMovies(successCallback: ([Movie]) -> Void){
        let url = httpClient.buildUrl("popular")
        httpClient.fetch(url, successCallback: successCallback, error: nil)
    }

    
}