//
//  RiwayatViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 25/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
//import Firebase

//MARK: -Search
class RiwayatViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private(set) var gridLayout: GridLayout!
    
    private var presenter: RiwayatViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = RiwayatViewPresenter(riwayatViewController: self)
        
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
