//
//  MovieCell.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    static let identifire = "MovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadowCell()
        setupCorenerRadiusCell()
    }

    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var filmGenre: UILabel!
    
    private func setupShadowCell() {
        let radius: CGFloat = 20
        layer.shadowColor = #colorLiteral(red: 0.8201048466, green: 0.8201048466, blue: 0.8201048466, alpha: 1)
        layer.shadowOffset = CGSize(width: 1, height: 3)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 1
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 20
        contentView.layer.cornerRadius = radius
        contentView.clipsToBounds = false
    }
}
extension MovieCell: ConfigureView {
    func configure(with model: MovieCellModel) {
        self.poster.image = model.poster
        self.movieTitle.text = model.movieTitle
        self.filmGenre.text = model.filmGenre
    }
    
    typealias Model = MovieCellModel
    
    
}
