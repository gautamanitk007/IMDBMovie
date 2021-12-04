//
//  APIService.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation

public class APIWorker: ServiceProtocol {
    
    var apiManager: APIManagerProtocol
    
    init(_ apiManager:APIManagerProtocol) {
        self.apiManager = apiManager
    }
    public func fetchMovies(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->()){
        
        var apiRequest:APIRequest!
        if let key = request.rKey, let type = request.rType, let page = request.rPage {
            apiRequest = APIRequest(searchParams: "&s=\(key)&type=\(type)&page=\(page)")
        }
        apiRequest.httpMethod = HttpMethod.get
        let transationResource = Resource<MovieListSceneDataModels.ResponseModel>(request: apiRequest) { data in
            let tResponse = try? JSONDecoder().decode(MovieListSceneDataModels.ResponseModel.self, from: data)
            return tResponse
        }
        self.apiManager.runAPI(resource: transationResource) { (response, error) in
            completion(response,error)
        }
    }
    public func fetchMovieDetails(request:MovieListSceneDataModels.Request, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->()){
        
    }
}

