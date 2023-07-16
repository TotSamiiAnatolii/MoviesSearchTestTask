//
//  UIImage+.swift
//  FilmTestTask
//
//  Created by APPLE on 16.07.2023.
//

import UIKit

public extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
