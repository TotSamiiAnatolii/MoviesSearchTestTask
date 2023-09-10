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
    
    func configureView(model: DetailModel)
}

final class DetailViewController: UIViewController {
    
    private var presenter: DetailMoviePresenterProtocol
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var filmDescription: UILabel!
    
    @IBOutlet weak var genre: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.controlActivityIndicator(state: .startAnimating)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func backButton(_ sender: UIButton) {
        presenter.popToRoot()
    }
}
extension DetailViewController: DetailMovieViewProtocol {
    
    func success(model: DetailModel) {
        configureView(model: model)
    }
    
    func failure() {
        activityIndicator.controlActivityIndicator(state: .stopAnimating)
    }
    
    func configureView(model: DetailModel) {
        activityIndicator.controlActivityIndicator(state: .stopAnimating)
        poster.loadImage(urlString: model.poster, placeholder: UIImage())
        movieTitle.text = model.movieTitle
        filmDescription.text = model.description
        genre.text = model.movieGenre
        country.text = model.country
        year.text = model.year
    }
}
