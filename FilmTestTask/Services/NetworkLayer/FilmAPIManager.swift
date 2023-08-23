//
//  FilmManager.swift
//  FilmTestTask
//
//  Created by APPLE on 23.08.2023.
//

import Foundation

protocol FilmManagerProtocol {
    
    func getTopListMovies(page: Int, completion: @escaping((Result<ModelTopListMovies, Error>) -> Void))
    
    func getDetailMovie(id: Int, completion: @escaping((Result<DetailsMovie, Error>) -> Void))
    
    func searchMovie(title: String, completion: @escaping((Result<SearchMovie, Error>) -> Void))
}

final class FilmAPIManager: FilmManagerProtocol {
    
    private let networkManager: NetworkServiceProtocol
    
    
    public init(networkManager: NetworkServiceProtocol) {
        self.networkManager = networkManager
    }
    
    func getTopListMovies(page: Int, completion: @escaping((Result<ModelTopListMovies, Error>) -> Void)) {
        
        guard let url = ApiBuilder.topList(page: page) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiBuilder.token.rawValue]
        networkManager.fetchModels(from: request, in: completion)
    }
    
    func getDetailMovie(id: Int, completion: @escaping ((Result<DetailsMovie, Error>) -> Void)) {
        
        guard let url = ApiBuilder.detailMovie(id: id) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiBuilder.token.rawValue]
        networkManager.fetchModels(from: request, in: completion)
    }
    
    func searchMovie(title: String, completion: @escaping ((Result<SearchMovie, Error>) -> Void)) {
        guard let url = ApiBuilder.searchMovie(title: title) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiBuilder.token.rawValue]
        networkManager.fetchModels(from: request, in: completion)
    }
}
