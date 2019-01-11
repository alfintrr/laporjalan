//
//  LaporanViewPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class LaporanViewPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private weak var laporanViewController: LaporanViewController?
    private(set) var dataSource: DataSource = DataSource()
    
    init(laporanViewController: LaporanViewController?){
        self.laporanViewController = laporanViewController
    }
    
    func fetchLaporan(){
        dataSource.fetchLaporan{[unowned self] (error) in
            if let error = error{
                print(error)
                print("gagal jalan")
            }else{
                self.laporanViewController?.collectionView.reloadData()
                print("presenter else jalan")
            }
            print("presenter 1 jalan")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let laporanTerpilih = dataSource.itemAt(indexPath) as? Laporan {
            laporanViewController?.performSegue(withIdentifier: "laporanTerpilih", sender: laporanTerpilih)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let viewController = laporanViewController {
            return viewController.gridLayout.itemSizeFor(4)
            
            
        } else {
            return CGSize(width: collectionView.frame.width, height: 100.0)
        }
    }
}
