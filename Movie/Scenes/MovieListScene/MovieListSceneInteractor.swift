//
//  MovieListSceneInteractor.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.


import UIKit

protocol MovieListSceneDataStore
{
  var totalResults: String { get set }
}

final class MovieListSceneInteractor {
    var totalResults: String?
    var presenter: MovieListScenePresentationLogic?
    var worker: APIWorker?
    init() {
        worker = APIWorker(APIManager())
    }
}

extension MovieListSceneInteractor: MovieListSceneBusinessLogic {
    func fetchMovie(request: MovieListSceneDataModels.Request) {
        self.worker?.fetchMovies(request: request) {[weak self] (response, error) in
            guard let self  = self else { return }
            if response?.Response?.boolValue == true {
                self.totalResults = response?.totalResults
                if let responseModel = response {
                    self.presenter?.presentMovies(response: responseModel)
                } else {
                    self.presenter?.presentErrors(error: ApiError(statusCode: -1, message: Utils.getLocalisedValue(key: "Unkown")))
                }
            } else {
                if error?.statusCode == ResponseCodes.success.rawValue {
                    self.presenter?.presentErrors(error: ApiError(statusCode: -1, message: Utils.getLocalisedValue(key: "Too_Many_Result")))
                } else {
                    self.presenter?.presentErrors(error: error ?? ApiError(statusCode: -1, message: Utils.getLocalisedValue(key: "Unkown")))
                }
            }
        }
    }
}
