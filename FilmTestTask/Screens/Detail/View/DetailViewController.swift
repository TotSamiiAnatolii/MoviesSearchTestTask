//
//  DetailViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    
    func success(model: DetailModel)
    
    func failure()
}

final class DetailViewController: UIViewController {
    
    var presenter: DetailMoviePresenterProtocol
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var filmDescription: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    init(presenter: DetailMoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }


    @IBAction func backButton(_ sender: UIButton) {
        presenter.popToRoot()
    }
}
extension DetailViewController: DetailMovieViewProtocol {
 
    func success(model: DetailModel) {
   
        poster.loadImage(url: model.poster)
        movieTitle.text = model.movieTitle
        filmDescription.text = model.description
        genre.text = model.movieGenre
        country.text = model.country
        year.text = model.year
    }
    
    func failure() {
        
    }
}
