//
//  SearchMoviesPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesPresenterProtocol {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func showDetailMovie(model: DetailModel)
    
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
    
    func showDetailMovie(model: DetailModel) {
        router.showMovie(model: model)
    }
    
    func searchMovies(title movie: String) {
//        networkService.....
    }
    
    func popToRoot() {
        router.popToRoot()
    }
}
