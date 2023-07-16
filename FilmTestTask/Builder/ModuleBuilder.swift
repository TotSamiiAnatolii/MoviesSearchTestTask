//
//  ModuleBuilder.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainMoviesList(router: RouterProtocol) -> UIViewController
    func createSearchMovies(router: RouterProtocol) -> UIViewController
    func createDetailMovie(id: Int, router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
    
    let networkService: NetworkManager
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
    }
    
    func createMainMoviesList(router: RouterProtocol) -> UIViewController {
        let presenter = MainMoviesListPresenter(networkService: networkService, router: router)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createDetailMovie(id: Int, router: RouterProtocol) -> UIViewController {
        let presenter = DetailMoviePresenter(id: id, networkService: networkService, router: router)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createSearchMovies(router: RouterProtocol) -> UIViewController {
        let presenter = SearchMoviesPresenter(networkService: networkService, router: router)
        let view = SearchMoviesController(presenter: presenter)
        presenter.view = view
        return view
    }
}
