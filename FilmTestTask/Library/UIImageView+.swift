//
//  UIImageView+.swift
//  FilmTestTask
//
//  Created by APPLE on 30.06.2023.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String) {
        guard let url1 = URL(string: url) else {
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url1) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
