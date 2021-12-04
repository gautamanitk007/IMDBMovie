//
//  APIProtocols.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation

public protocol ServiceProtocol {
    func fetchMovies(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->())
    func fetchMovieDetails(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->())
}

extension ServiceProtocol {
    public func fetchMovies(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->()){}
    public func fetchMovieDetails(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->()){}
}
