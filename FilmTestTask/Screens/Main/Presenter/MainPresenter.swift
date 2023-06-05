//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import Foundation

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func getListMovie()
    
    func showMovie(model: DetailModel)
    
    func showSearchMovies()
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    var view: MainMoviesListViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
    }

    func getListMovie() {
//        networkService
    }
    
    func showMovie(model: DetailModel) {
        router.showMovie(model: model)
    }
    
    func showSearchMovies() {
        router.showSearchMovies()
    }
}
