//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var listTopMovies: [MovieCellModel] {get set}
    
    func getListMovie(page: Int)
    
    func showMovie(index: Int)
    
    func showSearchMovies()
    
    func map(model: [Film]) -> [MovieCellModel]
    
    func failure(error: Error)
    
    func supplement()
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    var view: MainMoviesListViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var listTopMovies: [MovieCellModel] = []
    
    var page: Int = 1
    
    var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
        getListMovie(page: 1)
    }
    
    func getListMovie(page: Int) {
        view?.noInternetAlertManagement(isHidden: true)
        networkService.getTopListMovies(page: page) { result in
            switch result {
            case .success(let success):
                self.listTopMovies = self.map(model: success.films)
                DispatchQueue.main.async {
                    self.view?.success()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.view?.failure()
                }
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
            self.getListMovie(page: self.page)
        }
    }
    
    func supplement() {
        page += 1
        view?.controlActivityIndicator(state: true)
        networkService.getTopListMovies(page: page) { result in
            switch result {
            case .success(let success):
                self.listTopMovies.append(contentsOf: self.map(model: success.films))
                DispatchQueue.main.async {
                    self.view?.success()
                }
                self.view?.controlActivityIndicator(state: false)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
