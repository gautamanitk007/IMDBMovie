//
//  MovieListSceneDataModels.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.


import UIKit

public enum MovieListSceneDataModels {
    
    public struct Request {
        var rKey: String?
        var rType: String?
        var rPage: String?
        var isLoading: Bool?
    }
    public struct ResponseModel: Decodable {
        let Response: String?
        let Search: [SearchModel]?
        let totalResults: String?
        enum CodingKeys: String, CodingKey {
            case Response
            case Search
            case totalResults
        }
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            Response =  try values.decodeIfPresent(String.self, forKey: .Response)
            Search = try values.decodeIfPresent([SearchModel].self, forKey: .Search)
            totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults)
         
        }
    }
    public struct SearchModel: Decodable {
        let Title: String?
        let Year: String?
        let imdbID: String?
        let `Type`: String?
        let Poster: String?
        
        enum CodingKeys: String, CodingKey {
            case Title
            case Year
            case imdbID
            case `Type`
            case Poster
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            Title =  try values.decodeIfPresent(String.self, forKey: .Title)
            Year = try values.decodeIfPresent(String.self, forKey: .Year)
            imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
            Type = try values.decodeIfPresent(String.self, forKey: .Type)
            Poster = try values.decodeIfPresent(String.self, forKey: .Poster)
        }
    }
    public struct MovieViewModel{
        var movieTitle:String?
        var movieYear:String?
        var movieImdbID:String?
        var movieThumUrl:String?
    }
    public struct ViewError {
        var errorMessage:String
    }
}
