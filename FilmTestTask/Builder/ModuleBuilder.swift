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
    func createAlert(title: String, message: String, btnTitle: String, action: @escaping (() -> Void)) -> UIAlertController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
 
    func createMainMoviesList(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkManager()
        let presenter = MainMoviesListPresenter(networkService: networkService, router: router)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createDetailMovie(id: Int, router: RouterProtocol) -> UIViewController {
        let networkService = NetworkManager()
        let presenter = DetailMoviePresenter(id: id, networkService: networkService, router: router)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createSearchMovies(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkManager()
        let presenter = SearchMoviesPresenter(networkService: networkService, router: router)
        let view = SearchMoviesController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func createAlert(title: String, message: String, btnTitle: String, action: @escaping (() -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: btnTitle, style: .default) { _ in
            action()
        }
        alertController.addAction(action)
        return alertController
    }
}
