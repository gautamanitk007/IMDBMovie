//
//  APIWorkerTests.swift
//  MovieTests
//
//  Created by Gautam Singh on 6/12/21.
//

import XCTest
@testable import Movie

final class APIWorkerTests: XCTestCase {
    var sut: ServiceProtocol!
    override func setUp() {
        sut = APIWorker(APIManager())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    func test_fetch_movie_api_valid_response_with_nil_string() {
        //Given
        let movieListExpectation = self.expectation(description: "Call fetch Movie API")
        let request = MovieListSceneDataModels.Request(rKey: nil, rType: "", rPage: "1", isLoading: false)

        //When
        sut.fetchMovies(request: request) { (response, error) in
            movieListExpectation.fulfill()
            //Then
            XCTAssertEqual(response?.Response?.boolValue, false)
            XCTAssertNil(response?.Search)
            XCTAssertNil(response?.totalResults)
            XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_fetch_movie_api_valid_response_with_empty_string() {
        //Given
        let movieListExpectation = self.expectation(description: "Call fetch Movie API")
        let request = MovieListSceneDataModels.Request(rKey: "", rType: "", rPage: "1", isLoading: false)

        //When
        sut.fetchMovies(request: request) { (response, error) in
            movieListExpectation.fulfill()
            //Then
            XCTAssertEqual(response?.Response?.boolValue, false)
            XCTAssertNil(response?.Search)
            XCTAssertNil(response?.totalResults)
            XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func test_fetch_movie_api_valid_response_with_valid_string() {
        //Given
        let movieListExpectation = self.expectation(description: "Call fetch Movie API")
        let request = MovieListSceneDataModels.Request(rKey: "mar", rType: "Movie", rPage: "1", isLoading: false)

        
        //When
        sut.fetchMovies(request: request) { (response, error) in
            movieListExpectation.fulfill()
            //Then
            XCTAssertEqual(response?.Response?.boolValue, true)
            XCTAssertEqual(response?.Search?.count, 10)
            XCTAssertTrue(response?.totalResults?.intValue ?? 0 > 0)
            XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func test_fetch_movie_details_api_with_invalid_string() {
        //Given
        let movieDetailExpectation = self.expectation(description: "Call fetch Movie detail API")
        let detailRequest = MovieDetailsSceneModels.Request(imdbID: "")
    
        sut.fetchMovieDetails(request: detailRequest) { (response, error) in
            movieDetailExpectation.fulfill()
            //Then
            XCTAssertEqual(response?.Response?.boolValue, false)
            XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func test_fetch_movie_details_api_with_valid_string() {
    
        //Given
        let movieListExpectation = self.expectation(description: "Call fetch Movie API")
        let request = MovieListSceneDataModels.Request(rKey: "mar", rType: "Movie", rPage: "1", isLoading: false)
        let movieDetailExpectation = self.expectation(description: "Call fetch Movie detailAPI")
        var detailRequest = MovieDetailsSceneModels.Request(imdbID: "")
        
        //When
        sut.fetchMovies(request: request) { (response, error) in
            movieListExpectation.fulfill()
            //Then
            XCTAssertEqual(response?.Response?.boolValue, true)
            XCTAssertEqual(response?.Search?.count, 10)
            XCTAssertTrue(response?.totalResults?.intValue ?? 0 > 0)
            XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
            
            //Given
            let imdbId = response?.Search?.first?.imdbID
            detailRequest.imdbID = imdbId
            
            self.sut.fetchMovieDetails(request: detailRequest) { (response, error) in
                movieDetailExpectation.fulfill()
                //Then
                XCTAssertEqual(response?.Response?.boolValue, true)
                XCTAssertEqual(error?.statusCode, ResponseCodes.success.rawValue)
            }
        }
        wait(for: [movieListExpectation,movieDetailExpectation], timeout: 3.0)
    }
}

