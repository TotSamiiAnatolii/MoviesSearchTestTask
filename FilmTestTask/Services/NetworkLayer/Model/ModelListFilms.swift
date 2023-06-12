//
//  ModelListFilms.swift
//  FilmTestTask
//
//  Created by APPLE on 11.06.2023.
//

import Foundation

// MARK: - Movie
struct ReleaseMovie: Codable {
    let page, total: Int?
    let releases: [Release]?
}

// MARK: - Release
struct Release: Codable {
    let filmID: Int
    let nameRu, nameEn: String
    let year: Int
    let posterURL: String
    let posterURLPreview: String
    let countries: [Country]
    let genres: [Genre]
    let rating: Double
    let ratingVoteCount: Int
    let expectationsRating: Double
    let expectationsRatingVoteCount, duration: Int
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu, nameEn, year
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case countries, genres, rating, ratingVoteCount, expectationsRating, expectationsRatingVoteCount, duration, releaseDate
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}
