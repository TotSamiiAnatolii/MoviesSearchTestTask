//
//  SearchMoviesPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesPresenterProtocol {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func showDetailMovie(id: Int)
    
    func searchMovies(title movie: String)
    
    func popToRoot()
    
    func viewDidLoad()
    
    func setViewState()
}

final class SearchMoviesPresenter: SearchMoviesPresenterProtocol {
    
    weak var view: SearchMoviesViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    private var router: RouterProtocol
    
    private var stateView: StateSearchViewModel = .loading  {
        didSet {
            setViewState()
        }
    }
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func showDetailMovie(id: Int) {
        router.showMovie(id: id)
    }
    
    func searchMovies(title movie: String) {
        let maper = Maper()
        networkService.searchMovie(title: movie) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.stateView = .search(maper.map(model: success.films))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stateView = .error(error)
                }
            }
        }
    }
    
    func popToRoot() {
        router.popToRoot()
    }
    
    func setViewState() {
        switch stateView {
        case .loading:
            view?.controlViewNotFound(isHidden: false)
        case .search(let movie):
            view?.controlViewNotFound(isHidden: true)
            view?.success(model: movie)
        case .notFound:
            view?.controlViewNotFound(isHidden: false)
            view?.success(model: [])
        case .error(_):
            view?.failure()
        }
    }
}
