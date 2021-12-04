//
//  MovieDetailsSceneModels.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit

public enum MovieDetailsSceneModels {
    
    public struct Request {
        var imdbID:String?
    }
    public struct Response: Decodable {
        let Response: String?
        let Runtime: String?
        let Title: String?
        let `Type`: String?
        let Website: String?
        let Writer: String?
        let Year: String?
        let imdbID: String?
        let imdbRating: String?
        let imdbVotes: String?
        let Ratings: [Rating]?
        let Actors: String?
        let Awards: String?
        let BoxOffice: String?
        let Country: String?
        let DVD: String?
        let Director: String?
        let Genre: String?
        let Language: String?
        let Metascore: String?
        let Plot: String?
        let Poster: String?
        let Production: String?
        let Rated: String?
        enum CodingKeys: String, CodingKey {
            case Response
            case Ratings
            case imdbVotes
            case imdbRating
            case imdbID
            case Year
            case Writer
            case Website
            case `Type`
            case Title
            case Runtime
            case Actors
            case Awards
            case BoxOffice
            case Country
            case DVD
            case Director
            case Genre
            case Language
            case Metascore
            case Plot
            case Poster
            case Production
            case Rated
        }
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            Response =  try values.decodeIfPresent(String.self, forKey: .Response)
            Ratings = try values.decodeIfPresent([Rating].self, forKey: .Ratings)
            imdbVotes = try values.decodeIfPresent(String.self, forKey: .imdbVotes)
            imdbRating = try values.decodeIfPresent(String.self, forKey: .imdbRating)
            imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
            Year = try values.decodeIfPresent(String.self, forKey: .Year)
            Writer = try values.decodeIfPresent(String.self, forKey: .Writer)
            Website = try values.decodeIfPresent(String.self, forKey: .Website)
            `Type` = try values.decodeIfPresent(String.self, forKey: .`Type`)
            Title = try values.decodeIfPresent(String.self, forKey: .Title)
            Runtime = try values.decodeIfPresent(String.self, forKey: .Runtime)
            
            Actors = try values.decodeIfPresent(String.self, forKey: .Actors)
            Awards = try values.decodeIfPresent(String.self, forKey: .Awards)
            BoxOffice = try values.decodeIfPresent(String.self, forKey: .BoxOffice)
            Country = try values.decodeIfPresent(String.self, forKey: .Country)
            
            DVD = try values.decodeIfPresent(String.self, forKey: .DVD)
            Director = try values.decodeIfPresent(String.self, forKey: .Director)
            Genre = try values.decodeIfPresent(String.self, forKey: .Genre)
            Language = try values.decodeIfPresent(String.self, forKey: .Language)
            Metascore = try values.decodeIfPresent(String.self, forKey: .Metascore)
            Plot = try values.decodeIfPresent(String.self, forKey: .Plot)
            Poster = try values.decodeIfPresent(String.self, forKey: .Poster)
            Production = try values.decodeIfPresent(String.self, forKey: .Production)
            Rated = try values.decodeIfPresent(String.self, forKey: .Rated)
        }
    }
    public struct Rating: Decodable {
        let Source: String?
        let Value: String?
        enum CodingKeys: String, CodingKey {
            case Source
            case Value
        }
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            Source =  try values.decodeIfPresent(String.self, forKey: .Source)
            Value = try values.decodeIfPresent(String.self, forKey: .Value)
        }
    }
    public struct ViewModel {
        var title:String?
        var year:String?
        var rating:String?
        var thumbUrl:String?
        var actor:String?
        var director:String?
        var writer:String?
        var synopsis:String?
        var runTime:String?
        var score:String?
        var imdbRating:String?
        var startRating:String?
        var imdbVotes:String?
    }

    public struct ViewError {
        var errorMessage:String
    }
}
