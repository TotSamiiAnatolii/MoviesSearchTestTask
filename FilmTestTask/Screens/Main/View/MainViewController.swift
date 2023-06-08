//
//  MainViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

protocol MainMoviesListViewProtocol {
    
}

final class MainViewController: UIViewController {

    var presenter: MainMoviesListPresenterProtocol
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func jjjjjj(_ sender: UIButton) {
        print("search")
    }
    @IBAction func adf(_ sender: Any) {
        print("search")
    }
    
    @IBAction func sdsssd(_ sender: Any) {
        print("search")
    }
    
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
//        setupNavBar()
        self.navigationController?.navigationBar.isHidden = true
        prepareCollectionView()
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = myCompositionalLayout.setLayoutCollection()
        collectionView.register(UINib(nibName: MovieCell.identifire, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifire)
    }
    
//    private func setupNavBar() {
//        let width = (self.navigationController?.navigationBar.frame.width)!
//        let height = (self.navigationController?.navigationBar.frame.height)!
//        
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        titleView.backgroundColor = .red
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        navigationItem.titleView = titleView
//    }

}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifire, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: MovieCellModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovie(model: DetailModel(image: UIImage(), nameFilm: "", description: "", movieGenre: "", country: "", year: ""))
    }
}
extension MainViewController: MainMoviesListViewProtocol {
    
}
