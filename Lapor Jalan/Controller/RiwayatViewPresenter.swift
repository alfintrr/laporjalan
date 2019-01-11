//
//  RiwayatViewPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 10/11/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class RiwayatViewPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private weak var riwayatViewController: RiwayatViewController?
    private(set) var dataSource: RiwayatDataSource = RiwayatDataSource()
    
    init(riwayatViewController: RiwayatViewController?){
        self.riwayatViewController = riwayatViewController
    }
    
    func fetchLaporan(){
        dataSource.fetchLaporan{[unowned self] (error) in
            if let error = error{
                print(error)
                print("gagal jalan")
            }else{
                self.riwayatViewController?.collectionView.reloadData()
                
                print("presenter else jalan")
            }
            print("presenter 1 jalan")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let laporanTunggal = dataSource.itemAt(indexPath) as? Laporan {
            riwayatViewController?.performSegue(withIdentifier: "laporanTunggal", sender: laporanTunggal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // let item = dataSource.itemAt(indexPath)
        if let viewController = riwayatViewController {
            return viewController.gridLayout.itemSizeFor(1)
            //jelajahViewController?.gridLayout.itemSizeFor(3)
            
        } else {
            return CGSize(width: collectionView.frame.width, height: 100.0)
        }
    }
    
    
    
}
