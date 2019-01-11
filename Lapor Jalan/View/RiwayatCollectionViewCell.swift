//
//  RiwayatCollectionViewCell.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 10/11/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class RiwayatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lokasiLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var laporanView: UIView!
    @IBOutlet weak var tanggalLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lokasiLabel.text = nil
        statusLabel.text = nil
        tanggalLabel.text = nil
    }
    
    func fillWith(_ laporan: Laporan){
        lokasiLabel.text = laporan.lokasi
        statusLabel.text = laporan.status
        tanggalLabel.text = laporan.tanggal
        changeBackground()
        //shadowView()
        
    }
    
    func changeBackground(){
        if statusLabel.text == "Belum Ditinjau"{
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.red
        }else if statusLabel.text == "Ditinjau"{
            statusLabel.textColor = UIColor.black
            statusLabel.backgroundColor = UIColor.yellow
        }else if statusLabel.text == "Diperbaiki"{
            statusLabel.textColor = UIColor.black
            statusLabel.backgroundColor = UIColor.green
        }else if statusLabel.text == "Selesai"{
            statusLabel.textColor = UIColor.white
            statusLabel.backgroundColor = UIColor.blue
        }
    }
}
