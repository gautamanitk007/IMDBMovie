//
//  MovieListSceneProtocol.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation


protocol MovieListSceneDisplayLogic: AnyObject {
    func dispayMovieList(movieList:[MovieListSceneDataModels.MovieViewModel])
    func displayErrors(viewErrorModel: MovieListSceneDataModels.ViewError)
}

protocol MovieListSceneBusinessLogic: AnyObject {
    func fetchMovie(request: MovieListSceneDataModels.Request)
}

protocol MovieListScenePresentationLogic: AnyObject {
    func presentMovies(response: MovieListSceneDataModels.ResponseModel)
    func presentErrors(error: ApiError)
}
