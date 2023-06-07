//
//  CollectionLayout.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

final class MyCompositionalLayout {
    
     func setLayoutCollection() -> UICollectionViewLayout {
         let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let items = NSCollectionLayoutItem(layoutSize: itemsSize)
        
         let groupsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let groups = NSCollectionLayoutGroup.horizontal(layoutSize: groupsSize, subitem: items, count: 1)
        
        let section = NSCollectionLayoutSection(group: groups)
         
        section.interGroupSpacing = 15
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
