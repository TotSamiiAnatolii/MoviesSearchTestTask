//
//  Router.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol RouterMain {
    
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showMovie(id: Int)
    func showSearchMovies()
    func popToRoot()
}

final class Router: RouterProtocol {
  
    var navigationController: UINavigationController
    
    var assemblyBuilder: AssemblyBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        let mainMoviesListVC = assemblyBuilder.createMainMoviesList(router: self)
        navigationController.viewControllers = [mainMoviesListVC]
    }
    
    func showMovie(id: Int) {
        let detailMovieVC = assemblyBuilder.createDetailMovie(id: id, router: self)
        navigationController.pushViewController(detailMovieVC, animated: true)
    }
    
    func showSearchMovies() {
        let searchMoviesVC = assemblyBuilder.createSearchMovies(router: self)
        navigationController.pushViewController(searchMoviesVC, animated: true)
    }
    
    func popToRoot() {
        navigationController.popViewController(animated: true)
    }
}
