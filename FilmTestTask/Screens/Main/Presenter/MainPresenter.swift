//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func getListMovie()
    
    func showMovie(index: Int)
    
    func showSearchMovies()
    
    func map(model: [Film]) -> [MovieCellModel]
    
    func failure(error: Error)
    
    var listTopMovies: [MovieCellModel] {get set}
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    var view: MainMoviesListViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var listTopMovies: [MovieCellModel] = []
    
    var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
        getListMovie()
    }
    
    func getListMovie() {
        networkService.getTopListMovies(page: 1) { result in
            switch result {
            case .success(let success):
                self.listTopMovies = self.map(model: success.films)
                DispatchQueue.main.async {
                    self.view?.success()
                }
            case .failure(let failure):
                self.failure(error: failure)
            }
        }
    }
    
    func showMovie(index: Int) {
        router.showMovie(id: listTopMovies[index].id)
    }
    
    func showSearchMovies() {
        router.showSearchMovies()
    }
    func map(model: [Film]) -> [MovieCellModel] {
        return model.map { currency in

            return MovieCellModel(
                id: currency.filmId,
                poster: currency.posterURLPreview ?? currency.posterUrl,
                movieTitle: currency.nameRu,
                filmGenre: currency.genres.first?.genre ?? "Error")
        }
    }
    
    func failure(error: Error) {
        router.alert(title: "Error",
                     message: error.localizedDescription,
                     btnTitle: "Повторить") {
            self.getListMovie()
        }
    }
}
