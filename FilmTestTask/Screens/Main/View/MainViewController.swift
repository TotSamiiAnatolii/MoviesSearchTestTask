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
    
    func setViewState(stateView: StateViewModel)
    
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
    
    private let mainTitle = "Фильмы"
    
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
        configureNavigationBar()
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
    
    private func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = mainTitle
        titleLabel.font = Fonts.mainTitle
        
        let searchButton = UIBarButtonItem(image: Images.search, landscapeImagePhone: Images.search, style: .plain, target: self, action: #selector(searhButton))
        
        self.setupNavBar(leftItem: UIBarButtonItem(customView: titleLabel), rightItem: searchButton, titleView: nil)
    }

    @IBAction func repeatButton(_ sender: Any) {
        presenter.getListMovie()
    }
    
    @objc func refresh(_ sender:AnyObject) {
        listTopMovies.removeAll()
        presenter.getListMovie()
    }
    
    @objc func searhButton() {
        presenter.showSearchMovies()
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
        if indexPath.row < listTopMovies.count {
            cell.configure(with: listTopMovies[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = listTopMovies[safe: indexPath.row] else {
            return
        }
        presenter.showMovie(id: movie.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == listTopMovies.count - 8 {
            presenter.supplement()
        }
       
    }
}
extension MainViewController: MainMoviesListViewProtocol {
    
    func controlActivityIndicator(indicator: LoadingIndicator) {
        switch indicator {
        case .main(let state):
            mainActivityIndicator.controlActivityIndicator(state: state)
            
        case .paging(let state):
            pagingActivityIndicator.controlActivityIndicator(state: state)
        }
    }

    func noInternetAlertManagement(isHidden: Bool) {
        noInternetStackView.isHidden = isHidden
    }

    func success(model: [MovieCellModel]) {
        listTopMovies.append(contentsOf: model)
        noInternetAlertManagement(isHidden: true)
        collectionView.reloadData()
    }
    
    func failure() {
        noInternetAlertManagement(isHidden: false)
    }
    
    func setViewState(stateView: StateViewModel) {
        switch stateView {
        case .loading:
            controlActivityIndicator(indicator: .main(.startAnimating))
        case .paging:
            controlActivityIndicator(indicator: .paging(.startAnimating))
        case .populated(let movie):
            success(model: movie)
            controlActivityIndicator(indicator: .main(.stopAnimating))
            controlActivityIndicator(indicator: .paging(.stopAnimating))
        case .empty:
            success(model: [])
        case .error(_):
            failure()
        }
    }
}
