//
//  LinimasaViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 25/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class LinimasaViewController: UIViewController{
    
    let gambarJalan = ["cameraico","cameraico","cameraico","cameraico","cameraico","cameraico","cameraico","cameraico","cameraico"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension LinimasaViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return gambarJalan.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.gambarJalan.image = UIImage(named: (gambarJalan[indexPath.row] + ".jpg"))
        cell.namaJalan.text = "Nama jalan"
        cell.tingkatKerusakan.text = "Ukuran lubang"
        cell.pelapor.text = "Pelapor"
        
        return(cell)
    }
}
