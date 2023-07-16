//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var currentPage: Int {get set}
    
    func getListMovie(page: Int)
    
    func showMovie(id: Int)
    
    func showSearchMovies()
    
    func viewDidLoad()
    
    func supplement()
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    weak var view: MainMoviesListViewProtocol?
    
    let networkService: NetworkServiceProtocol
    
    var currentPage: Int = 1
    
    var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
        
    }
    
    func viewDidLoad() {
        getListMovie(page: currentPage)
    }
    
    func getListMovie(page: Int) {
        let maper = Maper()
        view?.noInternetAlertManagement(isHidden: true)
        networkService.getTopListMovies(page: page) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.view?.success(model: maper.map(model: success.films))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.view?.failure()
                }
            }
        }
    }
    
    func showMovie(id: Int) {
        router.showMovie(id: id)
    }
    
    func showSearchMovies() {
        router.showSearchMovies()
    }
    
    func supplement() {
        currentPage += 1
        view?.controlActivityIndicator(state: true)
        getListMovie(page: currentPage)
    }
}
