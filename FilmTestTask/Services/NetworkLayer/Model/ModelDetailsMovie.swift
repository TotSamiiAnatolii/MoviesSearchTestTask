//
//  ModelDetailsMovie.swift
//  FilmTestTask
//
//  Created by APPLE on 12.06.2023.
//

import Foundation

struct DetailsMovie: Codable {
//    let kinopoiskID: Int?
//    let imdbID: String?
    let nameRu: String
//    let nameEn: String?
//    let nameOriginal: String?
    let posterURL: String
//    let posterURLPreview: String?
//    let coverURL: String?
//    let logoURL: String?
//    let reviewsCount: Int
//    let ratingGoodReview: Double
//    let ratingGoodReviewVoteCount: Int
//    let ratingKinopoisk: Double
//    let ratingKinopoiskVoteCount: Int
//    let ratingImdb: Double
//    let ratingImdbVoteCount: Int
//    let ratingFilmCritics: Double
//    let ratingFilmCriticsVoteCount: Int
//    let ratingAwait: Double
//    let ratingAwaitCount: Int
//    let ratingRFCritics: Double
//    let ratingRFCriticsVoteCount: Int
//    let webURL: String
    let year: Int
//    let filmLength: Int
//    let slogan: String
    let description: String
//    let shortDescription: String
//    let editorAnnotation: String
//    let isTicketsAvailable: Bool
//    let productionStatus: String
//    let type: String
//    let ratingMPAA: String
//    let ratingAgeLimits: String
//    let hasImax: Bool
//    let has3D: Bool
//    let lastSync: String
    let countries: [Country]
    let genres: [Genre]
//    let startYear: Int
//    let endYear: Int
//    let serial: Bool
//    let shortFilm: Bool
//    let completed: Bool

    enum CodingKeys: String, CodingKey {
//        case kinopoiskID = "kinopoiskId"
//        case imdbID = "imdbId"
        case nameRu
//        case nameEn, nameOriginal
        case posterURL = "posterUrl"
//        case posterURLPreview = "posterUrlPreview"
//        case coverURL = "coverUrl"
//        case logoURL = "logoUrl"
//        case reviewsCount, ratingGoodReview, ratingGoodReviewVoteCount, ratingKinopoisk, ratingKinopoiskVoteCount, ratingImdb, ratingImdbVoteCount, ratingFilmCritics, ratingFilmCriticsVoteCount, ratingAwait, ratingAwaitCount
//        case ratingRFCritics = "ratingRfCritics"
//        case ratingRFCriticsVoteCount = "ratingRfCriticsVoteCount"
//        case webURL = "webUrl"
        case year
//        case filmLength, slogan
        case description
//        case shortDescription, editorAnnotation, isTicketsAvailable, productionStatus, type
//        case ratingMPAA = "ratingMpaa"
//        case ratingAgeLimits, hasImax, has3D, lastSync
        case countries
             case genres
//        case startYear, endYear, serial, shortFilm, completed
    }
}

//// MARK: - Country
//struct Country: Codable {
//    let country: String
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let genre: String
//}
