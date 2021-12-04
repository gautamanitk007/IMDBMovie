//
//  MovieDetailsSceneInteractor.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit

final class MovieDetailsSceneInteractor {
    
    var presenter: MovieDetailsScenePresentationLogic?
    var worker: APIWorker?
    
    init() {
        worker = APIWorker(APIManager())
    }
}

extension MovieDetailsSceneInteractor: MovieDetailsSceneBusinessLogic {
    func fetchMovieDetails(request: MovieDetailsSceneModels.Request?) {
        DispatchQueue.global().async { [weak self] in
            guard let self  = self else { return }
            self.worker?.fetchMovieDetails(request: request, on: { [weak self] (response, error) in
                guard let self  = self else { return }
                if response?.Response?.boolValue == true {
                    if let responseModel = response {
                        self.presenter?.presentMovieDetails(response: responseModel)
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
            })
        }
    }
}
