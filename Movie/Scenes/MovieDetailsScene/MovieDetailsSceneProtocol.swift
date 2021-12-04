//
//  MovieDetailsSceneProtocol.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation

protocol MovieDetailsSceneDisplayLogic: AnyObject {
    func dispayMovieDetails(viewModel:MovieDetailsSceneModels.ViewModel)
    func displayErrors(viewErrorModel: MovieDetailsSceneModels.ViewError)
}

protocol MovieDetailsSceneBusinessLogic: AnyObject {
    func fetchMovieDetails(request: MovieDetailsSceneModels.Request?)
}

protocol MovieDetailsScenePresentationLogic: AnyObject {
    func presentMovieDetails(response: MovieDetailsSceneModels.Response)
    func presentErrors(error: ApiError)
}
