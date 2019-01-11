//
//  GridLayout.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 10/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//
// Credit to Sabminder
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {

    var numberOfColumns: Int = 3
    
    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        
        self.numberOfColumns = numberOfColumns
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemHeight() -> CGFloat {
        return 100
    }
    
    func itemHeight2() -> CGFloat {
        return 450
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                return CGSize(width: itemWidth, height: itemHeight())
            }
            
            // Default fallback
            return CGSize(width: 100, height: 100)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    func itemSizeFor(_ columnSize: Int, with height: CGFloat = 100.0) -> CGSize {
        guard let collectionView = collectionView else {
            return .zero
        }
        
        if columnSize == 1 {
            let itemWidth: CGFloat = collectionView.frame.width - self.minimumInteritemSpacing
            return CGSize(width: itemWidth, height: itemHeight())
        }else if columnSize == 2 {
            let itemWidth: CGFloat = collectionView.frame.width - self.minimumInteritemSpacing
            return CGSize(width: itemWidth, height: itemHeight2())
        }else if columnSize == 3 {
            let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
            return CGSize(width: itemWidth, height: height)
        }
        
        return .zero
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
    
}
