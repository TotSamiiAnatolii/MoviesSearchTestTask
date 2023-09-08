//
//  UIViewController.swift
//  FilmTestTask
//
//  Created by APPLE on 29.07.2023.
//

import UIKit

extension UIViewController {
    
    func setupNavBar(leftItem: UIBarButtonItem?, rightItem: UIBarButtonItem?, titleView: UIView?) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        appearance.setBackIndicatorImage(
            Images.backButton,
            transitionMaskImage: Images.backButton
        )
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.backButtonTitle = ""
        
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.titleView = titleView
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.286167413, green: 0.3597429991, blue: 0.6686067581, alpha: 1)
    }
}
