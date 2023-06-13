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
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
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
    
}
extension SearchMoviesController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
