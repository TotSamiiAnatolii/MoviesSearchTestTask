//
//  ModelFilmSearch.swift
//  FilmTestTask
//
//  Created by APPLE on 29.06.2023.
//

import UIKit

struct ModelFilmSearch {
    let id: Int
    let poster: UIImage
    let movieTitle: String
    let filmGenre: String
}

enum SectionType: Int {
    case movie
}

enum StateSearchViewModel {
    case loading
    case search([MovieCellModel])
    case notFound
    case error(Error)
}
