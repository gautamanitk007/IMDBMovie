//
//  MovieDetailsSceneRouter.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit

protocol MovieDetailsSceneRoutingLogic: Failure{
  func popToPrevious()
}


final class MovieDetailsSceneRouter {
    
  weak var viewController: MovieDetailsSceneViewController?
    
}

extension MovieDetailsSceneRouter: MovieDetailsSceneRoutingLogic {
    
    func showFailure(message: String) {
        let alertController = Utils.getAlert(title:Utils.getLocalisedValue(key:"Information_Error_Title"),message:message)
        self.viewController?.present(alertController, animated: true)
    }
    
    func popToPrevious(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
