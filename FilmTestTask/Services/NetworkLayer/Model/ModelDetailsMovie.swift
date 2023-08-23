//
//  ModelDetailsMovie.swift
//  FilmTestTask
//
//  Created by APPLE on 12.06.2023.
//

import Foundation

struct DetailsMovie: Codable {
    
    let nameRu: String
    let posterURL: String
    let year: Int
    let description: String
    let countries: [Country]
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        
        case nameRu
        case posterURL = "posterUrl"
        case year
        case description
        case countries
        case genres
    }
}
