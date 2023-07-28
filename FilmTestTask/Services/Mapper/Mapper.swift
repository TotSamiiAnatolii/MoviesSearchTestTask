//
//  Maper.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

protocol MapperProtocol {
    
    associatedtype InputType
    associatedtype OutputType
    
    func map(model: InputType) -> OutputType
}
extension MapperProtocol {
    
    func map(models: [InputType]) -> [OutputType] {
        models.map(map)
    }
}

final class Mapper: MapperProtocol {
    
    func map(model: Film) -> MovieCellModel {
        MovieCellModel(
            id: model.filmId,
            poster: model.posterURLPreview ?? model.posterUrl,
            movieTitle: model.nameRu,
            filmGenre: model.genres.first?.genre ?? "Error")
    }
}
