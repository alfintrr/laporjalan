//
//  DetailRiwayatViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/07/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class DetailRiwayatViewController: UIViewController{
    @IBOutlet weak var laporanImage: UIImageView!
    @IBOutlet weak var deskripsiLabel: UILabel!
    @IBOutlet weak var ukuranLabel: UILabel!
    
    var laporanTunggal: Laporan!
    
    var image = UIImage(named: "cameraico")
    var imageURL = "s.id/2NI1A"
    var deskripsi: String?
    var ukuran: String?
    

    // MARK: view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = laporanTerpilih.name
        
//        laporanTunggal.image
//        laporanTunggal.imageURL
//        laporanTunggal.deskripsi
//        laporanTunggal.kerusakan
        
        if let image = laporanTunggal.image {
            laporanImage.image = image
        } else {
            if let imageURL = URL(string: laporanTunggal.imageURL) {
                laporanImage.hnk_setImage(from: imageURL)
            }
        }
        
        if let deskripsi = laporanTunggal.deskripsi {
            deskripsiLabel.text = deskripsi
        } else {
            deskripsiLabel.isHidden = true
        }
        
        if let ukuran = laporanTunggal.kerusakan {
            ukuranLabel.text = ukuran
        } else {
            ukuranLabel.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let openMap = segue.destination as! MapRiwayatViewController

        if let lat = laporanTunggal.lat {
            openMap.lat = lat
        }
        if let long = laporanTunggal.long {
            openMap.long = long
        }

    }
}
