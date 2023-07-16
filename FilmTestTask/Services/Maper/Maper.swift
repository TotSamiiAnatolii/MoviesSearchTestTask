//
//  Maper.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

final class Maper {
    
    func map(model: [Film]) -> [MovieCellModel] {
        return model.map { currency in
            return MovieCellModel(
                id: currency.filmId,
                poster: currency.posterURLPreview ?? currency.posterUrl,
                movieTitle: currency.nameRu,
                filmGenre: currency.genres.first?.genre ?? "Error")
        }
    }
}
