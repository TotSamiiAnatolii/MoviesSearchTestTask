//
//  ActivitiIndicator.swift
//  FilmTestTask
//
//  Created by APPLE on 29.07.2023.
//

import UIKit

extension UIActivityIndicatorView {
    
    func controlActivityIndicator(state: StateLoadingIndicator) {
        switch state {
        case .startAnimating:
            self.isHidden = false
            self.startAnimating()
        case .stopAnimating:
            self.isHidden = true
            self.stopAnimating()
        }
    }
}

