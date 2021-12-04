//
//  MovieListSceneInteractor.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.


import UIKit

final class MovieListSceneInteractor {
    private var totalResults: String?
    private let valuePerReq: Int = 10
    var presenter: MovieListScenePresentationLogic?
    var worker: APIWorker?
    init() {
        worker = APIWorker(APIManager())
    }
}

extension MovieListSceneInteractor: MovieListSceneBusinessLogic {
    func fetchMovie(request: MovieListSceneDataModels.Request?) {
        guard let pageNum = request?.rPage?.intValue else { return }
        let totalCount = self.totalResults?.intValue ?? self.valuePerReq
        if pageNum * self.valuePerReq <= totalCount{
            DispatchQueue.global().async { [weak self] in
                guard let self  = self else { return }
                self.worker?.fetchMovies(request: request) {[weak self] (response, error) in
                    guard let self  = self else { return }
                    if response?.Response?.boolValue == true {
                        if let totalValue = response?.totalResults, totalValue.intValue <= self.valuePerReq {
                            self.totalResults = "\(self.valuePerReq)"
                        } else {
                            self.totalResults = response?.totalResults
                        }
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
        }else {
            self.presenter?.presentStopFetching(isStop: true)
        }
    }
}
