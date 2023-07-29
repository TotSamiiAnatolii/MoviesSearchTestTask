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
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.titleView = titleView
    }
}
