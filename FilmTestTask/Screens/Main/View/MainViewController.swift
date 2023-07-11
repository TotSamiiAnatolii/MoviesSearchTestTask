//
//  MainViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListViewProtocol {
    
    func success()
    
    func failure()
    
    func noInternetAlertManagement(isHidden: Bool)
}

final class MainViewController: UIViewController {
    
    var presenter: MainMoviesListPresenterProtocol
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var noInternetStackView: UIStackView!
    
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        presenter.showSearchMovies()
    }
    
    @IBAction func repeatButton(_ sender: Any) {
        presenter.getListMovie(page: 1)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.listTopMovies.count - 1 {
            presenter.supplement()
         }
    }
}
extension MainViewController: MainMoviesListViewProtocol {
    func noInternetAlertManagement(isHidden: Bool) {
        noInternetStackView.isHidden = isHidden
    }
    

    func success() {
        noInternetAlertManagement(isHidden: true)
        collectionView.reloadData()
        
    }
    
    func failure() {
        noInternetAlertManagement(isHidden: false)
    }
}
