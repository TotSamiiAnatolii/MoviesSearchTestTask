//
//  APIBuilder.swift
//  FilmTestTask
//
//  Created by APPLE on 29.06.2023.
//

import Foundation

enum ApiBuilder: String {
    case token = "bf15ca58-d49b-4aed-8ba2-79b3ece545fd"
    case baseURL = "https://kinopoiskapiunofficial.tech/"
    
    static func topList(page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.1/films/top"
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return components.url
    }
    
    static func detailMovie(id: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.2/films/\(id)"
      
        return components.url
    }
    
    static func searchMovie(title: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kinopoiskapiunofficial.tech"
        components.path = "/api/v2.1/films/search-by-keyword"
        
        components.queryItems = [
            URLQueryItem(name: "keyword", value: title)
        ]
        return components.url
    }
}

