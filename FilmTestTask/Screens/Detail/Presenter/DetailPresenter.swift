//
//  DetailPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import Foundation

protocol DetailMoviePresenterProtocol {
    
    init(id: String, networkService: NetworkServiceProtocol)
    
    func getDeatilMovie(id: String)
}

final class DetailMoviePresenter: DetailMoviePresenterProtocol {
    
    weak var view: DetailMovieViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    init(id: String, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getDeatilMovie(id: id)
    }
    
    func getDeatilMovie(id: String) {
        print("V set")
//        networkService
    }
}
