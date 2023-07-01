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
        networkService.getTopListMovies(page: 1) { result in
            switch result {
            case .success(let success):
                self.listTopMovies = self.map(model: success.films)
                DispatchQueue.main.async {
                    self.view?.success()
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getListMovie() {
        //        networkService
    }
    
    func showMovie(index: Int) {
        router.showMovie(id: listTopMovies[index].id)
    }
    
    func showSearchMovies() {
        router.showSearchMovies()
    }
    func map(model: [Film]) -> [MovieCellModel] {
        return model.map { currency in
//            var image = UIImage()
//            let vodel =  MovieCellModel(
//                id: currency.filmId,
//                poster: currency.posterUrl,
//                movieTitle: currency.nameRu,
//                filmGenre: currency.genres.first?.genre ?? "Error")
            
//            networkService.getPhoto(url: currency.posterUrl) { result in
//                switch result {
//                case .success(let success):
//                    guard let poster = UIImage(data: success) else { return }
//                    image = poster
//
//                case .failure(_):
//                    image = UIImage()
//                }
//            }
            return MovieCellModel(
                id: currency.filmId,
                poster: currency.posterUrl,
                movieTitle: currency.nameRu,
                filmGenre: currency.genres.first?.genre ?? "Error")
        }
    }
}
