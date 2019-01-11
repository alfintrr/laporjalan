//
//  PerbaikanViewPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//


import UIKit

class PerbaikanViewPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private weak var prosesPerbaikanViewController: PerbaikanViewController?
    private(set) var dataSource: PerbaikanDataSource = PerbaikanDataSource()
    
    init(prosesPerbaikanViewController: PerbaikanViewController?){
        self.prosesPerbaikanViewController = prosesPerbaikanViewController
    }
    
    func fetchLaporan(){
        dataSource.fetchLaporan{[unowned self] (error) in
            if let error = error{
                print(error)
                print("gagal jalan")
            }else{
                self.prosesPerbaikanViewController?.collectionView.reloadData()
                print("presenter else jalan")
            }
            print("presenter 1 jalan")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let viewController = prosesPerbaikanViewController {
            return viewController.gridLayout.itemSizeFor(2)
            
            
        } else {
            return CGSize(width: collectionView.frame.width, height: 100.0)
        }
    }
    
    
    
}
