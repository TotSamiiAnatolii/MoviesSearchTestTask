//
//  CollectionLayout.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

final class MyCompositionalLayout {
    
     func setLayoutCollection() -> UICollectionViewLayout {
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let items = NSCollectionLayoutItem(layoutSize: itemsSize)
        
        let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupsSize, subitem: items, count: 1)
        
        let section = NSCollectionLayoutSection(group: groups)
        
        section.interGroupSpacing = 18
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
