//
//  DetailViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailMoviePresenterProtocol
    
    init(presenter: DetailMoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
extension DetailViewController: DetailMovieViewProtocol {
    
}
