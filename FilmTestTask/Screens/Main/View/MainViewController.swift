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
    
    func controlActivityIndicator(indicator: LoadingIndicator)
}

final class MainViewController: UIViewController {
    
    var presenter: MainMoviesListPresenterProtocol
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var repeatButton: UIButton!
    
    @IBOutlet weak var noInternetStackView: UIStackView!
    
    @IBOutlet weak var pagingActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
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
       
        pagingActivityIndicator.isHidden = true
        mainActivityIndicator.isHidden = true
        presenter.viewDidLoad()
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
        presenter.getListMovie()
    }
    
    @objc func refresh(_ sender:AnyObject) {
        listTopMovies.removeAll()
        presenter.getListMovie()
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
        guard let movie = listTopMovies[safe: indexPath.row] else {
            return
        }
        presenter.showMovie(id: movie.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == listTopMovies.count - 1 {
            presenter.supplement()
        }
    }
}
extension MainViewController: MainMoviesListViewProtocol {
    
    func controlActivityIndicator(indicator: LoadingIndicator) {
        switch indicator {
        case .main(let state):
            switch state {
            case .startAnimating:
                mainActivityIndicator.isHidden = false
                mainActivityIndicator.startAnimating()
            case .stopAnimating:
                mainActivityIndicator.isHidden = true
                mainActivityIndicator.stopAnimating()
            }
        case .paging(let state):
            switch state {
            case .startAnimating:
                pagingActivityIndicator.isHidden = false
                pagingActivityIndicator.startAnimating()
            case .stopAnimating:
                pagingActivityIndicator.isHidden = true
                pagingActivityIndicator.stopAnimating()
            }
        }
    }

    func noInternetAlertManagement(isHidden: Bool) {
        noInternetStackView.isHidden = isHidden
    }

    func success(model: [MovieCellModel]) {
        listTopMovies.append(contentsOf: model)
        refreshControl.endRefreshing()
        noInternetAlertManagement(isHidden: true)
//        controlActivityIndicator(indicator: .main)
//        controlActivityIndicator(indicator: .paging)
        collectionView.reloadData()
    }
    
    func failure() {
        noInternetAlertManagement(isHidden: false)
    }
}
