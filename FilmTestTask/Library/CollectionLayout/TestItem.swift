//
//  TestItem.swift
//  FilmTestTask
//
//  Created by APPLE on 05.06.2023.
//

import UIKit

@IBDesignable
class TestItem: UINavigationItem {

    
    let titleView1 = UIView(frame: CGRect(x: 0, y: 0, width: 100 , height: 50))
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            set()
        }
    }

    
   
    
    
    
    func set() {
        self.titleView = titleView1
    }
}
