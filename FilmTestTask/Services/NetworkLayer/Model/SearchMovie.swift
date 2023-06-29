//
//  SearchMovie.swift
//  FilmTestTask
//
//  Created by APPLE on 13.06.2023.
//

import Foundation

struct SearchMovie: Codable {
    let keyword: String
    let pagesCount: Int
    let searchFilmsCountResult: Int
    let films: [Film]
}
