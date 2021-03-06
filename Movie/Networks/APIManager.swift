//
//  APIManager.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import Foundation
protocol APIManagerProtocol {
    func runAPI<T>(resource:Resource<T>,completion:@escaping(T?,ApiError?)->())
}

public struct APIManager: APIManagerProtocol {
    
    func runAPI<T>(resource:Resource<T>,completion:@escaping(T?,ApiError?)->()){
        guard let urlRequest = resource.request.httpRequest else {
            DispatchQueue.main.async {
                completion(nil,ApiError(statusCode: ResponseCodes.badrequest.rawValue, message: "Bad request"))
            }
            return
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            var sError : ApiError?
            if let resp = response as? HTTPURLResponse{
                sError = ApiError(statusCode: resp.statusCode, message: HTTPURLResponse.localizedString(forStatusCode: resp.statusCode))
            }
            DispatchQueue.main.async {
                if let data = data {
                    //let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                    //print(jsonResponse)
                    completion(resource.parse(data),sError)
                }else{
                    if let err = sError {
                        completion(nil,err)
                    }else{
                        completion(nil,ApiError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1009, message: error?.localizedDescription))
                    }
                }
            }
            
        }.resume()
    }
}
