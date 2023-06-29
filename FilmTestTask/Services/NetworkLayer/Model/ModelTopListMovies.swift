//
//  ModelTopListMovies.swift
//  FilmTestTask
//
//  Created by APPLE on 11.06.2023.
//

import Foundation

struct ModelTopListMovies: Codable {
    var pagesCount: Int
    var films: [Film]
}

struct Film: Codable {
    var filmId: Int
    var nameRu: String
    var nameEn: String?
    var year: String
    var filmLength: String?
    var countries: [Countries]
    var genres: [Genres]
    var rating: String
    var ratingVoteCount: Int
    var posterUrl: String
    var posterURLPreview: String?
}

struct Countries: Codable {
    var country: String
}

struct Genres: Codable {
    var genre: String
}
