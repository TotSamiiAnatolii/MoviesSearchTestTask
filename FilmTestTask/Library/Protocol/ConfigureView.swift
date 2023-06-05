//
//  ConfigureView.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import Foundation

protocol ConfigureView {
    associatedtype Model
    
    func configure(with model: Model)
}
