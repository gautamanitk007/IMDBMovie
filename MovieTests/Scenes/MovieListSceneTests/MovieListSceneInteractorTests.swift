//
//  MovieListSceneInteractorTests.swift
//  Movie
//
//  Created by Gautam Singh on 8/12/21.


@testable import Movie
import XCTest

class MovieListSceneInteractorTests: XCTestCase {
    var sut: MovieListSceneInteractor!
    
    override func setUp() {
        super.setUp()
        sut = MovieListSceneInteractor()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }

    func test_fetchMovie_with_empty_request_string(){
        // Given
        let defaultExpection = self.expectation(description: "Default Expectation")
        let request = MovieListSceneDataModels.Request(rKey: "", rType: "", rPage: "1", isLoading: false)
        let spy = MovieListScenePresentationLogicSpy()
        sut.presenter = spy
        //When
        sut.fetchMovie(request: request)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            defaultExpection.fulfill()
            //Then
            XCTAssertNil(spy.model)
            XCTAssertNotNil(spy.apiError)
            XCTAssertEqual(spy.apiError?.statusCode, -1)
            XCTAssertEqual(spy.apiError?.message, Utils.getLocalisedValue(key: "Too_Many_Result"))
        }
        waitForExpectations(timeout: 2)
    }
    func test_fetchMovie_with_valid_request_string(){
        // Given
        let defaultExpection = self.expectation(description: "Default Expectation")
        let request = MovieListSceneDataModels.Request(rKey: "marvel", rType: "", rPage: "1", isLoading: false)
        let spy = MovieListScenePresentationLogicSpy()
        sut.presenter = spy
        //When
        sut.fetchMovie(request: request)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            defaultExpection.fulfill()
            //Then
            XCTAssertNil(spy.apiError)
            XCTAssertNotEqual(spy.apiError?.statusCode, -1)
            XCTAssertNotEqual(spy.apiError?.message, Utils.getLocalisedValue(key: "Too_Many_Result"))
            XCTAssertNotNil(spy.model)
            XCTAssertTrue(spy.model!.Response!.boolValue)
            XCTAssertEqual(spy.model!.Search!.count, 10)
        }
        waitForExpectations(timeout: 2)
    }
}

class MovieListScenePresentationLogicSpy: MovieListScenePresentationLogic
{
    var model: MovieListSceneDataModels.ResponseModel?
    func presentMovies(response: MovieListSceneDataModels.ResponseModel) {
        self.model = response
    }
    var apiError:ApiError?
    func presentErrors(error: ApiError) {
        self.apiError = error
    }
    var stopApiCall:Bool = false
    func presentStopFetching(isStop: Bool) {
        self.stopApiCall = isStop
    }
}
