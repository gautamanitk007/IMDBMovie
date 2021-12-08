//
//  MovieListScenePresenterTests.swift
//  Movie
//
//  Created by Gautam Singh on 8/12/21.

@testable import Movie
import XCTest

class MovieListScenePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MovieListScenePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMovieListScenePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMovieListScenePresenter()
  {
    sut = MovieListScenePresenter()
  }

}
class MovieListSceneDisplayLogicSpy: MovieListSceneDisplayLogic {
    func dispayMovieList(movieList: [MovieListSceneDataModels.MovieViewModel]) {
        
    }

    func displayErrors(viewErrorModel: MovieListSceneDataModels.ViewError) {
        
    }

    func displayAllDownloaded(isAllDone: Bool) {
        
    }
}
