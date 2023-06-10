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
    
    var presenter: SearchMoviesPresenterProtocol
    
    init(presenter: SearchMoviesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SearchMoviesController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    
    @IBAction func backButton(_ sender: Any) {
        presenter.popToRoot()
    }
}
extension SearchMoviesController: SearchMoviesViewProtocol {
    
}
