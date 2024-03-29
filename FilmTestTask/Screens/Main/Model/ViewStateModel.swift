//
//  ViewStateModel.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

enum StateViewModel {
    
    case loading
    case paging
    case populated([MovieCellModel])
    case empty
    case error(Error)
}

enum StateLoadingIndicator {
    case startAnimating
    case stopAnimating
}

enum LoadingIndicator {
    case main(StateLoadingIndicator)
    case paging(StateLoadingIndicator)
}
