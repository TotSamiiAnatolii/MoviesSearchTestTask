//
//  SearchMoviesController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesViewProtocol {
    
}

final class SearchMoviesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

}
extension SearchMoviesController: SearchMoviesViewProtocol {
    
}
