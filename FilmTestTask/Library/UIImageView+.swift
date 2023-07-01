//
//  UIImageView+.swift
//  FilmTestTask
//
//  Created by APPLE on 30.06.2023.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        let network = NetworkManager()
        network.getPhoto(url: url) { result in
            switch result {
            case .success(let success):
                guard let poster = UIImage(data: success) else {
                    return }
                DispatchQueue.main.async {
                    self.image = poster
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage()
                }
            }
        }
    }
}
