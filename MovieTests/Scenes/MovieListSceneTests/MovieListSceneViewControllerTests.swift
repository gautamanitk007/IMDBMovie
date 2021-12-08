//
//  MovieListSceneViewControllerTests.swift
//  Movie
//
//  Created by Gautam Singh on 8/12/21.


@testable import Movie
import XCTest

class MovieListSceneViewControllerTests: XCTestCase, UICollectionViewDelegate {
    private var sut: MovieListSceneViewController!

    override func setUp() {
        super.setUp()
        sut = MovieListSceneViewController()
        sut.loadView()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    func test_viewDidLoad(){
        // Given
        let defaultExpection = self.expectation(description: "Default Expectation")
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        sut.movieCollectionView = collectionView
        sut.datasource = MovieCollectionDatasource(cellIdentifier: Identifier.MovieCellIdentifier.rawValue,
                                              items: []){(cell,viewModel) in
            cell.configure(viewModel: viewModel)
        }
        //When
        sut.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else {return}
            defaultExpection.fulfill()
            //Then
            XCTAssertNotNil(self.sut.datasource)
            XCTAssertEqual(self.sut.datasource.items.count, 10)
        }
        waitForExpectations(timeout: 3)
    }
}

