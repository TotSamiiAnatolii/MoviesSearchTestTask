//
//  UIRefreshControl+.swift
//  FilmTestTask
//
//  Created by APPLE on 14.07.2023.
//

import UIKit

extension UIRefreshControl {
    func programaticallyBeginRefreshing(in collectionView: UICollectionView, refreshControl: UIRefreshControl) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        collectionView.setContentOffset(offsetPoint, animated: true)
        collectionView.setContentOffset(CGPoint(x: 0, y: collectionView.contentOffset.y - (refreshControl.frame.size.height)), animated: true)
    }
}
