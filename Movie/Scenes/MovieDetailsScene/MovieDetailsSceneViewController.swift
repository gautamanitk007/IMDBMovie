//
//  MovieDetailsSceneViewController.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit
final class MovieDetailsSceneViewController: BaseViewController {
    
    var interactor: MovieDetailsSceneBusinessLogic?
    var router: MovieDetailsSceneRoutingLogic?
    var movieKey: String?

    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblActor: UILabel!
    
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRunTime: UILabel!
    @IBOutlet weak var lblSynopsis: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movie Details"
        self.setup()
        self.startActivity()
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
        self.stopActivity()
        self.lblScore.text = viewModel.imdbRating
        self.lblRating.text = viewModel.startRating
        self.lblReview.text = viewModel.rating
        self.lblSynopsis.text = viewModel.synopsis
        self.lblRunTime.text = viewModel.runTime
        self.lblPopularity.text = viewModel.imdbVotes
        
        self.lblTitle.text = viewModel.title
        self.lblYear.text = viewModel.year
        
        self.lblDirector.text = viewModel.director
        self.lblWriter.text = viewModel.writer
        self.lblActor.text = viewModel.actor
    }
    
    func displayErrors(viewErrorModel: MovieDetailsSceneModels.ViewError) {
        self.stopActivity()
        self.router?.showFailure(message: viewErrorModel.errorMessage)
    }
}
