//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    func getListMovie(page: Int)
    
    func showMovie(id: Int)
    
    func showSearchMovies()
    
    func viewDidLoad()
    
    func supplement()
    
    func setViewState()
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    weak var view: MainMoviesListViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    private let pagingFile = PagingFile(currentPage: 1)
    
    private var stateView: StateViewModel {
        didSet {
            setViewState()
        }
    }
    
    private var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
        self.stateView = .loading
    }
    
    func viewDidLoad() {
        getListMovie(page: pagingFile.nextPage())
    }
    
    func getListMovie(page: Int) {
        let maper = Maper()
        view?.noInternetAlertManagement(isHidden: true)
        networkService.getTopListMovies(page: page) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.pagingFile.pageCount = success.pagesCount
                    self.stateView = .populated(maper.map(model: success.films))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.stateView = .error(error)
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
        stateView = .loading
        pagingFile.hasMorePages ? getListMovie(page: pagingFile.nextPage()) : view?.controlActivityIndicator(state: false)
    }
    
    func setViewState() {
        switch stateView {
        case .loading:
            view?.controlActivityIndicator(state: true)
        case .paging(let array, let isFully):
            view?.success(model: array)
        case .populated(let array):
            view?.success(model: array)
        case .empty:
            view?.success(model: [])
        case .error(_):
            view?.failure()
        }
    }
}
