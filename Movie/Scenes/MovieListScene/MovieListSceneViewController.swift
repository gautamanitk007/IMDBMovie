//
//  MovieListSceneViewController.swift
//  Movie
//
//  Created by Gautam Singh on 3/12/21.

import UIKit
enum Identifier:String {
    case MovieCellIdentifier = "MovieCelli"
}
final class MovieListSceneViewController: BaseViewController {
    
    var interactor: MovieListSceneBusinessLogic?
    var router: MovieListSceneRoutingLogic?
    private var loadPage: Int = 1
    private var isAllDone:Bool = false
    private var request: MovieListSceneDataModels.Request?
    private var searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var movieCollectionView: UICollectionView!
    var datasource : MovieCollectionDatasource<MovieCell,MovieListSceneDataModels.MovieViewModel>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.createSearchController()
        request = MovieListSceneDataModels.Request(rKey: "", rType: "movie",rPage: "\(self.loadPage)",isLoading: true)
        searchController.searchBar.text = "marvel"
    }
    @IBAction func didRefreshTapped(_ sender: Any) {
        self.loadPage += 1
        self.interactor?.fetchMovie(request: request)
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
    
    func isNextPageAvailable(collectionView:UICollectionView)-> Bool {
        let yOffset = collectionView.contentOffset.y;
        let height = collectionView.contentSize.height - collectionView.frame.height;
        return yOffset / height > 0.6;
    }
    
}

//MARK:- MovieListSceneDisplayLogic
extension MovieListSceneViewController: MovieListSceneDisplayLogic {
    func displayErrors(viewErrorModel: MovieListSceneDataModels.ViewError) {
        self.stopActivity()
        self.request?.isLoading = false
        self.router?.showFailure(message: viewErrorModel.errorMessage)
    }

    func dispayMovieList(movieList:[MovieListSceneDataModels.MovieViewModel]) {
        self.stopActivity()
        self.request?.isLoading = false
        self.datasource.updateItems(items: movieList)
        self.movieCollectionView.reloadData()
    }
    func displayAllDownloaded(isAllDone:Bool) {
        self.isAllDone = true
    }
    func resetAllPreviousSearchCricteriaAndResults() {
        self.isAllDone = false
        self.loadPage = 1
        // Clear datasource because user is searching another movie title
        self.datasource.removeAll()
        // Refresh the list
        self.movieCollectionView.reloadData()
    }
    func updateRequest(query:String?){
        self.request?.rKey = query
        self.request?.isLoading = true
        self.request?.rPage = "\(self.loadPage)"
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension MovieListSceneViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let queryString = searchController.searchBar.text
        guard let query = queryString, !query.isEmpty else { return }
        guard query.count > 2 else { return }
        if let key = request?.rKey {
            if key != query {
                self.resetAllPreviousSearchCricteriaAndResults()
            }
        }
        self.updateRequest(query: query)
        self.startActivity()
        self.interactor?.fetchMovie(request: request)
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
        let width = (self.movieCollectionView.frame.width - 20)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left:16, bottom: 10, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isNextPage = self.isNextPageAvailable(collectionView: collectionView)
        if self.isAllDone == false  && isNextPage && self.request?.isLoading == false{
            self.loadPage += 1
            self.updateRequest(query: self.searchController.searchBar.text)
            self.startActivity()
            self.interactor?.fetchMovie(request: request)
        }
    }
}
