//
//  MovieListSceneRouter.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.


import UIKit

protocol Failure {
    func showFailure(message: String)
}

protocol MovieListSceneRoutingLogic: Failure {
    func showMovieDetail(movieKey: String)
}

final class MovieListSceneRouter {
    
  weak var viewController: MovieListSceneViewController?
    
}

extension MovieListSceneRouter: MovieListSceneRoutingLogic {
    func showMovieDetail(movieKey: String) {
        guard let nextViewController = Utils.getViewController(identifier: "MovieDetailsScene") as? MovieDetailsSceneViewController else {
            fatalError("Controller doesn't exist")
        }
        nextViewController.movieKey = movieKey
        self.viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        viewController?.present(alertController, animated: true)
    }
}
