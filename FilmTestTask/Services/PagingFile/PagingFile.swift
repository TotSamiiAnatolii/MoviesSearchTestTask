//
//  Paging.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import Foundation

protocol PagingFileProtocol {
    
    init(currentPage: Int)
    var pageCount: Int {get set}
    var currentPage: Int {get set}
    var hasMorePages: Bool {get}
    func nextPage() -> Int
}

final class PagingFile: PagingFileProtocol {
    
    var pageCount: Int = 0
    
    var currentPage: Int
    
    init(currentPage: Int) {
        self.currentPage = currentPage
    }
        
    var hasMorePages: Bool {
        return currentPage < pageCount
    }
    
    func nextPage() -> Int {
        switch hasMorePages {
        case true:
            currentPage += 1
            return currentPage
        case false:
            return currentPage
        }
    }
}
