//
//  MovieDetailsScenePresenter.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit
final class MovieDetailsScenePresenter {
    
  weak var viewController: MovieDetailsSceneDisplayLogic?
    
}

extension MovieDetailsScenePresenter: MovieDetailsScenePresentationLogic{
    func presentMovieDetails(response: MovieDetailsSceneModels.Response) {
        let viewModel = MovieDetailsSceneModels.ViewModel(title: response.Title, year: response.Year, rating: response.Rated, thumbUrl: response.Poster, actor: response.Actors, director: response.Director, writer: response.Writer, synopsis: response.Plot, runTime: response.Runtime, score: response.Rated, imdbRating: response.imdbRating, startRating: "★\(response.imdbRating ?? "")",imdbVotes: response.imdbVotes)
        
        self.viewController?.dispayMovieDetails(viewModel: viewModel)
    }
    
    func presentErrors(error: ApiError) {
        self.viewController?.displayErrors(viewErrorModel: MovieDetailsSceneModels.ViewError(errorMessage: error.message!))
    }
}
