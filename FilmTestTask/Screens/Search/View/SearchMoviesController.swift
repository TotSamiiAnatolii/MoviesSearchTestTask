//
//  SearchMoviesController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol SearchMoviesViewProtocol: AnyObject {
    func success(model: [MovieCellModel])
    
    func failure()
}

final class SearchMoviesController: UIViewController {
    
    private var presenter: SearchMoviesPresenterProtocol
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    @IBOutlet weak var notFound: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var foundMovies: [MovieCellModel] = []
    
    @IBAction func search(_ sender: UITextField) {
        presenter.searchMovies(title: sender.text!)
    }
    
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
        prepareCollectionView()
    }

    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = myCompositionalLayout.setLayoutCollection()
        collectionView.register(UINib(nibName: MovieCell.identifire, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifire)
    }
    
    @IBAction func backButton(_ sender: Any) {
        presenter.popToRoot()
    }
}
extension SearchMoviesController: SearchMoviesViewProtocol {
    
    func success(model: [MovieCellModel]) {
        foundMovies = model
        notFound.isHidden = true
        collectionView.reloadData()
    }
    
    func failure() {
        foundMovies.removeAll()
        notFound.isHidden = false
        collectionView.reloadData()
    }
}
extension SearchMoviesController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foundMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: foundMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetailMovie(id: foundMovies[indexPath.row].id)
    }
}
