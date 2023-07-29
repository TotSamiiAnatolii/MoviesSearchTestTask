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
    
    func controlViewNotFound(isHidden: Bool)
}

final class SearchMoviesController: UIViewController {
    
    private var presenter: SearchMoviesPresenterProtocol
    
    private let myCompositionalLayout = MyCompositionalLayout()
    
    @IBOutlet weak var notFound: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, AnyHashable>?
    
    private var foundMovies: [MovieCellModel] = []
    
    private let placeholder = "Search"
    
    @objc func search(_ sender: UITextField) {
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
        prepareCollectionView()
        createDataSource()
        configureNavigationBar()
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = myCompositionalLayout.setLayoutCollection()
        collectionView.register(UINib(nibName: MovieCell.identifire, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifire)
    }
    
    private func configureNavigationBar() {
        guard let navigationController else {
            return
        }
        let heightNavBar = navigationController.navigationBar.bounds.height
        let widthNavBar = navigationController.navigationBar.bounds.width
        
        let searchBar = UITextField(frame: CGRect(x: 0, y: 0, width: widthNavBar, height: heightNavBar))
        searchBar.borderStyle = .none
        searchBar.placeholder = placeholder
        searchBar.addTarget(self, action: #selector(search), for: .allEditingEvents)
        let backButton = UIBarButtonItem(image: Images.backButton, landscapeImagePhone: Images.search, style: .done, target: self, action: #selector(backButton))
        self.setupNavBar(leftItem: backButton, rightItem: nil, titleView: searchBar)
    }
    
    @objc func backButton() {
        presenter.popToRoot()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let section = SectionType(rawValue: indexPath.section)
            
            switch section {
            case .movie:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
                    return UICollectionViewCell()
                }
                
                if indexPath.row < self.foundMovies.count {
                    cell.configure(with: self.foundMovies[indexPath.row])
                }
                return cell
            case .none:
                return UICollectionViewCell()
            }
        })
    }
    
    private func reloadData(array: [MovieCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, AnyHashable>()
        snapshot.appendSections([.movie])
        snapshot.appendItems(foundMovies, toSection: .movie)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
extension SearchMoviesController: SearchMoviesViewProtocol {
    func controlViewNotFound(isHidden: Bool) {
        notFound.isHidden = isHidden
    }
    
    
    func success(model: [MovieCellModel]) {
        foundMovies = model
        reloadData(array: model)
    }
    
    func failure() {
        foundMovies.removeAll()
        collectionView.reloadData()
    }
}
extension SearchMoviesController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetailMovie(id: foundMovies[indexPath.row].id)
    }
}
