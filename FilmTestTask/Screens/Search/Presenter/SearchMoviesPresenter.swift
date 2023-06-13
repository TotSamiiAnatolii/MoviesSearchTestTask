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
  
    var view: SearchMoviesViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func showDetailMovie(id: Int) {
        router.showMovie(id: id)
    }
    
    func searchMovies(title movie: String) {
        networkService.searchMovie(title: movie) { result in
            switch result {
            case .success(let success):
              print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func popToRoot() {
        router.popToRoot()
    }
}
