//
//  DetailJelajahViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 15/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//
// Credit to Sabminder
//

import Foundation
import UIKit
import Haneke

class DetailJelajahViewController: UIViewController{
    
    
    @IBOutlet weak var laporanImage: UIImageView!
    @IBOutlet weak var lokasiLabel: UILabel!
    @IBOutlet weak var deskripsiLabel: UILabel!
    @IBOutlet weak var ukuranLabel: UILabel!
    
    var laporanTerpilih: Laporan!
    
    // MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = laporanTerpilih.name
        if let image = laporanTerpilih.image {
            laporanImage.image = image
        } else {
            if let imageURL = URL(string: laporanTerpilih.imageURL) {
                laporanImage.hnk_setImage(from: imageURL)
            }
        }
        
        if let lokasi = laporanTerpilih.lokasi {
            lokasiLabel.text = lokasi
        } else {
            lokasiLabel.isHidden = true
        }
        
        if let deskripsi = laporanTerpilih.deskripsi {
            deskripsiLabel.text = deskripsi
        } else {
            deskripsiLabel.isHidden = true
        }
        
        if let ukuran = laporanTerpilih.kerusakan {
            ukuranLabel.text = ukuran
        } else {
            ukuranLabel.isHidden = true
        }
    }
    
    
}
