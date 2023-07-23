//
//  ViewStateModel.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

enum StateViewModel {
    
    case loading
    case paging([MovieCellModel], isFully: Bool)
    case populated([MovieCellModel])
    case empty
    case error(Error)
    
    
}
