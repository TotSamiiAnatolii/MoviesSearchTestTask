//
//  ViewStateModel.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

enum StateViewModel {
    
    case loader
    case paging([MovieCellModel], isFully: Bool)
    case erorr
}
