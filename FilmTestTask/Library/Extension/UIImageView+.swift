//
//  UIImageView+.swift
//  FilmTestTask
//
//  Created by APPLE on 30.06.2023.
//

import UIKit

var imageCashe = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString: String) {
        
        if let image = imageCashe.object(forKey: urlString as NSString) {
            self.image = image as? UIImage
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async{
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCashe.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                }
            }
        }
    }
}
