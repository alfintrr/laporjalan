//
//  LaporanViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class LaporanViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private(set) var gridLayout: GridLayout!
    
    private var presenter: LaporanViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LaporanViewPresenter(laporanViewController: self)
        
        gridLayout = GridLayout(numberOfColumns: 1)
        collectionView.collectionViewLayout = gridLayout
        collectionView.delegate = presenter
        collectionView.dataSource = presenter.dataSource
        collectionView.reloadData()
        presenter.fetchLaporan()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "laporanTunggal" {
            if let laporanTunggal = sender as? Laporan, let destinationViewController = segue.destination as? DetailRiwayatViewController {
                destinationViewController.laporanTunggal = laporanTunggal
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}
