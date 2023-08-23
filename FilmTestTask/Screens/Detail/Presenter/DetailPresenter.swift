//
//  DetailPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol DetailMoviePresenterProtocol {
    
    init(id: Int, filmAPIManager: FilmManagerProtocol, router: RouterProtocol)
    
    func getDeatilMovie(id: Int)
    
    func popToRoot()
}

final class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    weak var view: DetailMovieViewProtocol?
    
    private let filmAPIManager: FilmManagerProtocol
    
    private var router: RouterProtocol
    
    init(id: Int, filmAPIManager: FilmManagerProtocol, router: RouterProtocol) {
        self.filmAPIManager = filmAPIManager
        self.router = router
        getDeatilMovie(id: id)
    }
    
    func getDeatilMovie(id: Int) {
        
        filmAPIManager.getDetailMovie(id: id) { result in
            switch result {
            case .success(let success):
                
                DispatchQueue.main.async {
                    self.view?.success(model: self.parser(model: success))
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
    
    func parser(model: DetailsMovie) -> DetailModel {
        
        let genre: [String] = model.genres.map({ genre in
            return genre.genre
        })
        
        let country: [String] = model.countries.map { coutry in
            return coutry.country
        }
        
        return DetailModel(poster: model.posterURL,
                           movieTitle: model.nameRu,
                           description: model.description,
                           movieGenre: genre.joined(separator: ", "),
                           country: country.joined(separator: ", "),
                           year: "\(model.year)")
    }
}
