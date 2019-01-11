//
//  PerbaikanCollectionViewCell.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import Haneke

class PerbaikanCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lokasiLabel: UILabel!
    @IBOutlet weak var tanggalLabel: UILabel!
    @IBOutlet weak var deskripsiLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lokasiLabel.text = nil
        tanggalLabel.text = nil
        deskripsiLabel.text = nil
        imageView.hnk_cancelSetImage()
        imageView.image = nil
    }
    
    func fillWith(_ laporan: LaporanAdmin){
        lokasiLabel.text = laporan.thoroughfare
        tanggalLabel.text = laporan.tanggal
        deskripsiLabel.text = laporan.deskripsi
        imageView.image = laporan.image
        print("fill with jalan")
        
        
        if let url = URL(string: laporan.imageURL) {
            imageView.hnk_setImage(from: url)
        }
    }
}

