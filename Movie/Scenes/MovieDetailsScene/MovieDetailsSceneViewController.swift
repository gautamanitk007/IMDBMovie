//
//  MovieDetailsSceneViewController.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit
final class MovieDetailsSceneViewController: UIViewController {
    
    var interactor: MovieDetailsSceneBusinessLogic?
    var router: MovieDetailsSceneRoutingLogic?
    var movieKey: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.fetchMoviesDeatils()
    }
}

private extension MovieDetailsSceneViewController {
    func setup(){
        let viewController = self
        let interactor = MovieDetailsSceneInteractor()
        let presenter = MovieDetailsScenePresenter()
        let router = MovieDetailsSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    func fetchMoviesDeatils(){
        let request = MovieDetailsSceneModels.Request(imdbID: self.movieKey)
        self.interactor?.fetchMovieDetails(request: request)
    }
}

extension MovieDetailsSceneViewController: MovieDetailsSceneDisplayLogic {
    
    func dispayMovieDetails(viewModel: MovieDetailsSceneModels.ViewModel) {
        print(viewModel)
    }
    
    func displayErrors(viewErrorModel: MovieDetailsSceneModels.ViewError) {
        self.router?.showFailure(message: viewErrorModel.errorMessage)
    }
}
