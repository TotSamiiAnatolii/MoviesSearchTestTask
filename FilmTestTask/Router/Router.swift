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
    func showMovie(model: DetailModel)
    func showSearchMovies()
    func alert(title: String, message: String, btnTitle: String, action: @escaping (() -> Void))
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
    
    func showMovie(id: String) {
        let detailMovieVC = assemblyBuilder.createDetailMovie(model: model, router: self)
        navigationController.pushViewController(detailMovieVC, animated: true)
    }
    
    func showSearchMovies() {
        let searchMoviesVC = assemblyBuilder.createSearchMovies(router: self)
        navigationController.pushViewController(searchMoviesVC, animated: true)
    }
    
    func alert(title: String, message: String, btnTitle: String, action: @escaping (() -> Void)) {
//        let alertController = assemblyBuilder.createAlert(
//            title: title,
//            message: message,
//            btnTitle: btnTitle,
//            action: action)
//        navigationController.present(alertController, animated: true)
    }
}
