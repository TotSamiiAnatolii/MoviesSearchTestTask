//
//  MainPresenter.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListPresenterProtocol: AnyObject {
    
    init(filmAPIManager: FilmManagerProtocol, router: RouterProtocol)
    
    var startNumberPagin: Int { get }
    
    func getListMovie(page: Int)
    
    func showMovie(id: Int)
    
    func showSearchMovies()
    
    func viewDidLoad()
    
    func supplement()
}
extension MainMoviesListPresenterProtocol {
    func getListMovie() {
        getListMovie(page: startNumberPagin)
    }
}

final class MainMoviesListPresenter: MainMoviesListPresenterProtocol {
    
    weak var view: MainMoviesListViewProtocol?
    
    private let filmAPIManager: FilmManagerProtocol
    
    internal let startNumberPagin = 1
    
    private lazy var pagingFile = PagingFile(currentPage: startNumberPagin)
    
    private var stateView: StateViewModel = .loading  {
        didSet {
            view?.setViewState(stateView: stateView)
        }
    }
   
    private var router: RouterProtocol
    
    private let mapper = Mapper()
    
    init(filmAPIManager: FilmManagerProtocol, router: RouterProtocol) {
        self.router = router
        self.filmAPIManager = filmAPIManager
    }
    
    func viewDidLoad() {
        view?.setViewState(stateView: stateView)
        getListMovie()
    }
    
    func getListMovie(page: Int = 1) {
        view?.noInternetAlertManagement(isHidden: true)
        filmAPIManager.getTopListMovies(page: page) { result in
            switch result {
            case .success(let success):
                let poster = success.films.map{URL(string: $0.posterUrlPreview)}
                
                poster.forEach { film in
                    ImageDownloader.shared.warmCache(with: film!)
                }
                
                DispatchQueue.main.async {
                    self.pagingFile.pageCount = success.pagesCount
                    self.stateView = .populated(self.mapper.map(models: success.films))
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
}
