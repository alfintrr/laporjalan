
//
//  ViewPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 14/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//
// Credit to Sabminder
//

import UIKit

class ViewPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private weak var jelajahViewController: JelajahViewController?
    private(set) var dataSource: DataSource = DataSource()
    
    init(jelajahViewController: JelajahViewController?){
        self.jelajahViewController = jelajahViewController
    }
    
    func fetchLaporan(){
        dataSource.fetchLaporan{[unowned self] (error) in
            if let error = error{
                print(error)
                print("gagal jalan")
            }else{
                self.jelajahViewController?.collectionView.reloadData()
                print("presenter else jalan")
            }
            print("presenter 1 jalan")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let laporanTerpilih = dataSource.itemAt(indexPath) as? Laporan {
            jelajahViewController?.performSegue(withIdentifier: "laporanTerpilih", sender: laporanTerpilih)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let viewController = jelajahViewController {
                return viewController.gridLayout.itemSizeFor(3)

            
        } else {
            return CGSize(width: collectionView.frame.width, height: 100.0)
        }
    }
}
