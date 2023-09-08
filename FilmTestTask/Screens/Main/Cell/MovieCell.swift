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
        self.contentView.backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadowCell()
        setupCorenerRadiusCell()
    }
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? touchDown() : touchUp()
        }
    }

    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var filmGenre: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.image = nil
        movieTitle.text = nil
        filmGenre.text = nil
    }
    
    private func setupShadowCell() {
        let radius: CGFloat = 20
        layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        layer.shadowOffset = CGSize(width: 1, height: 6)
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
    
    private func touchDown() {
        let scaleX = 0.98
        let scaleY = 0.98
        
        transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    
    private func  touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
}
extension MovieCell: ConfigureView {
    func configure(with model: MovieCellModel) {
        self.movieTitle.text = model.movieTitle
        self.filmGenre.text = model.filmGenre
        self.poster.loadImage(urlString: model.poster, placeholder: UIImage())
    }
    typealias Model = MovieCellModel
}

