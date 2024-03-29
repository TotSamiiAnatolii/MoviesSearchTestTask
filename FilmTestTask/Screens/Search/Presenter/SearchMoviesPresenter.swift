//
//  SearchMoviesPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesPresenterProtocol {
    
    init(filmAPIManager: FilmManagerProtocol, router: RouterProtocol)
    
    func showDetailMovie(id: Int)
    
    func searchMovies(title movie: String)
    
    func popToRoot()
    
    func setViewState()
}

final class SearchMoviesPresenter: SearchMoviesPresenterProtocol {
    
    weak var view: SearchMoviesViewProtocol?
    
    private let filmAPIManager: FilmManagerProtocol
    
    private var router: RouterProtocol
    
    private var stateView: StateSearchViewModel = .loading  {
        didSet {
            setViewState()
        }
    }
    
    private let mapper = Mapper()
    
    init(filmAPIManager: FilmManagerProtocol, router: RouterProtocol) {
        self.filmAPIManager = filmAPIManager
        self.router = router
    }
  
    func showDetailMovie(id: Int) {
        router.showMovie(id: id)
    }
    
    func searchMovies(title movie: String) {
        filmAPIManager.searchMovie(title: movie) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.stateView = .search(self.mapper.map(models: success.films))
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
            view?.controlViewNotFound(isHidden: true)
            view?.controlActivityIndicator(indicator: .main(.startAnimating))
        case .search(let movie):
            view?.controlActivityIndicator(indicator: .main(.stopAnimating))
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
