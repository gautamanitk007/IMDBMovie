//
//  MovieManager.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.
//

import Foundation

class MovieManager:NSObject {
    static let shared = MovieManager()
    var enableMock: Bool = false
    var baseURL: String = "http://www.omdbapi.com/?apikey=b9bd48a6"
    var isNetworkAvailable:Bool = false
}
