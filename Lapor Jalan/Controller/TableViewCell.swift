//
//  TableViewCell.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 28/06/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var gambarJalan: UIImageView!
    @IBOutlet weak var namaJalan: UILabel!
    @IBOutlet weak var tingkatKerusakan: UILabel!
    @IBOutlet weak var pelapor: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
