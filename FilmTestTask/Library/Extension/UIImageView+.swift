//
//  UIImageView+.swift
//  FilmTestTask
//
//  Created by APPLE on 30.06.2023.
//

import UIKit

extension UIImageView {

    func loadImage(urlString: String, placeholder: UIImage) {
        
        self.image = placeholder
        let urlHash = UUID().hashValue
        tag = urlHash
        
        ImageDownloader.shared.getImage(for: urlString, completion: { data in
            
            DispatchQueue.global(qos: .userInitiated).async {
                let image = data
                DispatchQueue.main.async {
                    guard self.tag == urlHash else {
                        return
                    }
                    self.image = image
                }
            }
        }, useCash: false)
    }
}
