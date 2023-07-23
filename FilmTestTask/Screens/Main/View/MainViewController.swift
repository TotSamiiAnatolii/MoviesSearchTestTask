//
//  MainViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListViewProtocol: AnyObject  {
   
    func success(model: [MovieCellModel])
    
    func failure()
    
    func noInternetAlertManagement(isHidden: Bool)
    
    func controlActivityIndicator(state: Bool)
}

final class MainViewController: UIViewController {
    
    var presenter: MainMoviesListPresenterProtocol
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var noInternetStackView: UIStackView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let refreshControl = UIRefreshControl()
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    private var listTopMovies: [MovieCellModel] = []
    
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
        presenter.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = myCompositionalLayout.setLayoutCollection()
        collectionView.register(UINib(nibName: MovieCell.identifire, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifire)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        presenter.showSearchMovies()
    }
    
    @IBAction func repeatButton(_ sender: Any) {
        presenter.getListMovie(page: 1)
    }
    
    @objc func refresh(_ sender:AnyObject) {
        presenter.getListMovie(page: 1)
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listTopMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: listTopMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovie(id: listTopMovies[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == listTopMovies.count - 1 {
            presenter.supplement()
        }
    }
}
extension MainViewController: MainMoviesListViewProtocol {
    
    func controlActivityIndicator(state: Bool) {
        switch state {
        case true:
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        case false:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    func noInternetAlertManagement(isHidden: Bool) {
        noInternetStackView.isHidden = isHidden
    }

    func success(model: [MovieCellModel]) {
        listTopMovies.append(contentsOf: model)
        refreshControl.endRefreshing()
        noInternetAlertManagement(isHidden: true)
        controlActivityIndicator(state: false)
        collectionView.reloadData()
    }
    
    func failure() {
        noInternetAlertManagement(isHidden: false)
    }
}
