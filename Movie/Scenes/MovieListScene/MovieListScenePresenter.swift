//
//  MovieListScenePresenter.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.


import UIKit

final class MovieListScenePresenter {
    weak var viewController: MovieListSceneDisplayLogic?
  
}

extension MovieListScenePresenter: MovieListScenePresentationLogic {
    
    func presentMovies(response: MovieListSceneDataModels.ResponseModel) {
        var viewModelList = [MovieListSceneDataModels.MovieViewModel]()
        for search in response.Search!  {
            let moviewModel = MovieListSceneDataModels.MovieViewModel(movieTitle: search.Title,
                                                             movieYear: search.Year,
                                                             movieImdbID: search.imdbID,
                                                             movieThumUrl: search.Poster)
            viewModelList.append(moviewModel)
        }
        self.viewController?.dispayMovieList(movieList: viewModelList)
    }
    
    func presentErrors(error: ApiError) {
        if error.statusCode == ResponseCodes.apiKey_invalid.rawValue {
            self.viewController?.displayErrors(viewErrorModel:
                                                MovieListSceneDataModels.ViewError(errorMessage:Utils.getLocalisedValue(key: "Error_API") ))
        } else {
            self.viewController?.displayErrors(viewErrorModel: MovieListSceneDataModels.ViewError(errorMessage: error.message!))
        }
    }
}
