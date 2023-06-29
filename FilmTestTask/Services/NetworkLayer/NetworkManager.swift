//
//  NetworkManager.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol NetworkServiceProtocol: AnyObject {
    
    func getTopListMovies(page: Int, completion: @escaping((Result<ModelTopListMovies, Error>) -> Void))
    
    func getDetailMovie(id: Int, completion: @escaping((Result<DetailsMovie, Error>) -> Void))
    
    func searchMovie(title: String, completion: @escaping((Result<SearchMovie, Error>) -> Void))
    
    func getReleases(year: Int, month: String, page: Int, completion: @escaping((Result<ReleaseMovie, Error>) -> Void))
    
    func getPhoto(url: String, completion: @escaping((Result<Data, Error>) -> Void))
}

final class NetworkManager: NetworkServiceProtocol {
 
    func getPhoto(url: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    
    func getTopListMovies(page: Int, completion: @escaping((Result<ModelTopListMovies, Error>) -> Void)) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.1/films/top"
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiUrl.token.rawValue]
        fetchModels(from: request, in: completion)
    }
    
    func getDetailMovie(id: Int, completion: @escaping ((Result<DetailsMovie, Error>) -> Void)) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.2/films/\(id)"
      
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiUrl.token.rawValue]
        fetchModels(from: request, in: completion)
    }
    
    func searchMovie(title: String, completion: @escaping ((Result<SearchMovie, Error>) -> Void)) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.1/films/search-by-keyword"
        
        components.queryItems = [
            URLQueryItem(name: "keyword", value: title)
        ]
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiUrl.token.rawValue]
        fetchModels(from: request, in: completion)
    }
    
    func getReleases(year: Int, month: String, page: Int, completion: @escaping((Result<ReleaseMovie, Error>) -> Void))  {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.1/films/releases"
        
        components.queryItems = [
            URLQueryItem(name: "year", value: "\(year)"),
            URLQueryItem(name: "month", value: month.uppercased()),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": ApiUrl.token.rawValue]
        fetchModels(from: request, in: completion)
    }
    
    private func fetchModels<T: Decodable>(from url: URLRequest, in completion: @escaping ((Result<T, Error>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            
            do {
                print(data)
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            }
            catch {
                completion(.failure(error))
                print("decode error: \(error)")
            }
        }.resume()
    }
}
