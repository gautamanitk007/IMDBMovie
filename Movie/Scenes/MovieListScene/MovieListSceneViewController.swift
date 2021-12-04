//
//  MovieListSceneViewController.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit
enum Identifier:String {
    case MovieCellIdentifier = "MovieCelli"
}
final class MovieListSceneViewController: UIViewController {
    
    var interactor: MovieListSceneBusinessLogic?
    var router: (NSObjectProtocol & MovieListSceneRoutingLogic & MovieListSceneDataPassing)?
    private var loadPage: Int = 1
    private var movieList: [MovieListSceneDataModels.MovieViewModel]?
    private var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var datasource : MovieCollectionDatasource<MovieCell,MovieListSceneDataModels.MovieViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.createSearchController()
        searchController.searchBar.text = "mar"
    }
    @IBAction func didRefreshTapped(_ sender: Any) {
        self.loadPage += 1
        self.interactor?.fetchMovie(request: MovieListSceneDataModels.Request(rKey: "Marvel", rType: "movie",rPage: "\(self.loadPage)"))
    }
}

//MARK:- Private Methods
private extension MovieListSceneViewController {
    func setup() {
        let viewController = self
        let interactor = MovieListSceneInteractor()
        let presenter = MovieListScenePresenter()
        let router = MovieListSceneRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        //router.dataStore = interactor
        viewController.datasource = MovieCollectionDatasource(cellIdentifier: Identifier.MovieCellIdentifier.rawValue,
                                              items: []){(cell,viewModel) in
            cell.configure(viewModel: viewModel)
        }
        viewController.movieCollectionView.dataSource = viewController.datasource
        viewController.movieCollectionView.delegate = viewController
    }
    func createSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter movie title(min 3 chars)"
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = .white
        }
        searchController.searchBar.barStyle = .default
        searchController.searchBar.keyboardAppearance = .light
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
}

//MARK:- MovieListSceneDisplayLogic
extension MovieListSceneViewController: MovieListSceneDisplayLogic {
    func displayErrors(viewErrorModel: MovieListSceneDataModels.ViewError) {
        self.router?.showFailure(message: viewErrorModel.errorMessage)
    }

    func dispayMovieList(movieList:[MovieListSceneDataModels.MovieViewModel]) {
        self.datasource.updateItems(items: movieList)
        self.movieCollectionView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension MovieListSceneViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let queryString = searchController.searchBar.text
        guard let query = queryString, !query.isEmpty else { return }
        guard query.count > 2 else { return }
        self.interactor?.fetchMovie(request: MovieListSceneDataModels.Request(rKey: query,
                                                                              rType: "movie",rPage: "\(self.loadPage)"))
    }
}

//MARK:- UICollectionViewDelegate
extension MovieListSceneViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieViewModel = self.datasource.getItem(indexPath: indexPath)
        self.router?.showMovieDetail(movieKey: movieViewModel.movieImdbID!)
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension MovieListSceneViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.movieCollectionView.frame.width - 40)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left:8, bottom: 10, right: 8)
    }
}
