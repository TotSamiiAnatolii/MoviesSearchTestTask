//
//  MainViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListViewProtocol {
    
    func success()
}

final class MainViewController: UIViewController {
    
    var presenter: MainMoviesListPresenterProtocol
    
    @IBOutlet weak var collectionView: UICollectionView!
    
  
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    init(presenter: MainMoviesListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "MainViewController", bundle: nil)
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
    
    
    @IBAction func searchButton(_ sender: Any) {
        presenter.showSearchMovies()
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.listTopMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: presenter.listTopMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovie(index: indexPath.row)
    }
}
extension MainViewController: MainMoviesListViewProtocol {
   
    func success() {
        collectionView.reloadData()
    }
}
