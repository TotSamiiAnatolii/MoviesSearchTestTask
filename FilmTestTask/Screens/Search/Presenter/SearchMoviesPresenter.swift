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
}

final class SearchMoviesPresenter: SearchMoviesPresenterProtocol {
    
    weak var view: SearchMoviesViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    private var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
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
                    self.view?.success(model: maper.map(model: success.films))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.failure()
                }
            }
        }
    }
    
    func popToRoot() {
        router.popToRoot()
    }
}
