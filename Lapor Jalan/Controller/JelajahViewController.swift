//
//  JelajahViewControlle.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 09/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//
// Credit to Sabminder
//

import Foundation
import UIKit

class JelajahViewController: UIViewController{
    

    @IBOutlet weak var collectionView:UICollectionView!
    
    var gridLayout: GridLayout!

    private var presenter: ViewPresenter!

    
    override func viewDidLoad(){
        super.viewDidLoad()

        presenter = ViewPresenter(jelajahViewController: self)
        gridLayout = GridLayout(numberOfColumns: 3)
        collectionView.collectionViewLayout = gridLayout
        collectionView.delegate = presenter
        collectionView.dataSource = presenter.dataSource
        collectionView.reloadData()
        presenter.fetchLaporan()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "laporanTerpilih" {
            if let laporanTerpilih = sender as? Laporan, let destinationViewController = segue.destination as? DetailJelajahViewController {
                destinationViewController.laporanTerpilih = laporanTerpilih
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

}
