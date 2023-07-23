//
//  Collection+.swift
//  FilmTestTask
//
//  Created by APPLE on 23.07.2023.
//

import Foundation

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
