//
//  PerbaikanViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import UIKit

class PerbaikanViewController: UIViewController{
    
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var gridLayout: GridLayout!
    
    private var presenter: PerbaikanViewPresenter!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        presenter = PerbaikanViewPresenter(prosesPerbaikanViewController: self)
        gridLayout = GridLayout(numberOfColumns: 3)
        collectionView.collectionViewLayout = gridLayout
        collectionView.delegate = presenter
        collectionView.dataSource = presenter.dataSource
        collectionView.reloadData()
        presenter.fetchLaporan()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
