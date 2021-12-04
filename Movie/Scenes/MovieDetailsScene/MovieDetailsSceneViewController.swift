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

    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblActor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Details"
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
        
        
        self.lblDirector.text = viewModel.director
        self.lblWriter.text = viewModel.writer
        self.lblActor.text = viewModel.actor
    }
    
    func displayErrors(viewErrorModel: MovieDetailsSceneModels.ViewError) {
        self.router?.showFailure(message: viewErrorModel.errorMessage)
    }
}
