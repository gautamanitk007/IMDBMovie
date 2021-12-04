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
    public func fetchMovies(request:MovieListSceneDataModels.Request?, on completion:@escaping(MovieListSceneDataModels.ResponseModel?,ApiError?)->()){
        var apiRequest:APIRequest!
        if let key = request?.rKey, let type = request?.rType, let page = request?.rPage {
            apiRequest = APIRequest(searchParams: "&s=\(key)&type=\(type)&page=\(page)")
        }
        apiRequest.httpMethod = HttpMethod.get
        let movieResource = Resource<MovieListSceneDataModels.ResponseModel>(request: apiRequest) { data in
            let tResponse = try? JSONDecoder().decode(MovieListSceneDataModels.ResponseModel.self, from: data)
            return tResponse
        }
        self.apiManager.runAPI(resource: movieResource) { (response, error) in
            completion(response,error)
        }
    }
    public func fetchMovieDetails(request:MovieDetailsSceneModels.Request?, on completion:@escaping(MovieDetailsSceneModels.Response?,ApiError?)->()){
        var apiRequest:APIRequest!
        if let key = request?.imdbID {
            apiRequest = APIRequest(searchParams: "&i=\(key)")
        }
        apiRequest.httpMethod = HttpMethod.get
        let movieDetails = Resource<MovieDetailsSceneModels.Response>(request: apiRequest) { data in
            let movieResponse = try? JSONDecoder().decode(MovieDetailsSceneModels.Response.self, from: data)
            return movieResponse
        }
        self.apiManager.runAPI(resource: movieDetails) { (response, error) in
            completion(response,error)
        }
    }
}

