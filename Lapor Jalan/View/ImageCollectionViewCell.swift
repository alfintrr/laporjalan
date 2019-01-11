//
//  ImageCollectionViewCell.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 09/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//
// Credit to Sabminder
//

import UIKit
import Haneke

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("reuse")
        imageView.hnk_cancelSetImage()
        imageView.image = nil
//        print(kerusakanLabel.text!)
    }
    
    func fillWith(_ laporan: Laporan) {
        imageView.image = laporan.image
        print("fill with jalan")

        
        if let url = URL(string: laporan.imageURL) {
            imageView.hnk_setImage(from: url)
        }
    }
    
}
