//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var startNumberPagin: Int {get}
    
    func getListMovie(page: Int)
    
    func showMovie(id: Int)
    
    func showSearchMovies()
    
    func viewDidLoad()
    
    func supplement()
    
    func setViewState()
}
extension MainMoviesListPresenterProtocol {
    func getListMovie() {
        getListMovie(page: startNumberPagin)
    }
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    weak var view: MainMoviesListViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    internal let startNumberPagin = 1
    
    private lazy var pagingFile = PagingFile(currentPage: startNumberPagin)
    
    private var stateView: StateViewModel = .loading  {
        didSet {
            setViewState()
        }
    }
    
    private var router: RouterProtocol
    
    init(networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.router = router
        self.networkService = networkService
    }
    
    func viewDidLoad() {
        setViewState()
        getListMovie(page: pagingFile.nextPage())
    }
    
    func getListMovie(page: Int = 1) {
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
        stateView = .paging
        pagingFile.hasMorePages ? getListMovie(page: pagingFile.nextPage()) : view?.controlActivityIndicator(indicator: .paging(.stopAnimating))
    }
    
    func setViewState() {
        switch stateView {
        case .loading:
            view?.controlActivityIndicator(indicator: .main(.startAnimating))
        case .paging:
            view?.controlActivityIndicator(indicator: .paging(.startAnimating))
        case .populated(let movie):
            view?.success(model: movie)
            view?.controlActivityIndicator(indicator: .main(.stopAnimating))
            view?.controlActivityIndicator(indicator: .paging(.stopAnimating))
        case .empty:
            view?.success(model: [])
        case .error(_):
            view?.failure()
        }
    }
}
