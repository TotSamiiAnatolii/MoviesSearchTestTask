//
//  SearchMoviesPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesPresenterProtocol {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func showDetailMovie(index: Int)
    
    func searchMovies(title movie: String)
    
    func popToRoot()
    
    func map(model: [Film]) -> [MovieCellModel]
    
    var foundMovies: [MovieCellModel] {get set}
}

final class SearchMoviesPresenter: SearchMoviesPresenterProtocol {
    
    var view: SearchMoviesViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var router: RouterProtocol
    
    var foundMovies: [MovieCellModel] = []
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.router = router
    }
    
    func showDetailMovie(index: Int) {
        router.showMovie(id: foundMovies[index].id)
    }
    
    func searchMovies(title movie: String) {
        networkService.searchMovie(title: movie) { result in
            switch result {
            case .success(let success):
                self.foundMovies = self.map(model: success.films)
                DispatchQueue.main.async {
                    self.view?.success()
                }
            case .failure(_):
                self.foundMovies.removeAll()
                DispatchQueue.main.async {
                    self.view?.failure()
                }
            }
        }
    }
    
    func popToRoot() {
        router.popToRoot()
    }
    
    func map(model: [Film]) -> [MovieCellModel] {
        return model.map { currency in
            
            return MovieCellModel(
                id: currency.filmId,
                poster: currency.posterUrl,
                movieTitle: currency.nameRu,
                filmGenre: currency.genres.first?.genre ?? "Error")
        }
    }
}
