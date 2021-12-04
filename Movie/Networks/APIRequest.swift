//
//  APIRequest.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation


public enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}
public enum ResponseCodes: Int {
    case success = 200
    case badrequest = 400
    case apiKey_invalid = 401
    case network_timeout = -1001
}
public enum ContentType: String {
    case json = "application/json"
}

public enum Accept: String {
    case accept = "application/json"
}

public struct ApiError{
    let statusCode:Int
    let message:String?
}
public struct Resource<T>{
    let request: APIRequest
    let parse:(Data) -> T?
}
public struct APIRequest {
    var httpMethod: HttpMethod = .post
    var contentType: ContentType = .json
    var accept: Accept = .accept
    var timeout: Double = 60.0
    var searchParams: String
    var urlString: String {
        return MovieManager.shared.baseURL + searchParams
    }
    
    var httpRequest: URLRequest? {
        guard let url = URL(string: self.urlString) else { return nil}
        var request: URLRequest  = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = self.timeout
        request.setValue(self.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        request.setValue(self.accept.rawValue, forHTTPHeaderField: "Accept")
        return request
    }
    init(searchParams: String) {
        self.searchParams = searchParams
    }
}
