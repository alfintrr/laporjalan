//
//  MenuViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 24/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import Foundation

class MenuViewController: UIViewController {
    
    var isSideMenuShowing = false
//
//
//    @IBOutlet weak var sideMenu: UIView!
//

    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    @IBAction func unwindFromLaporView(_ sender: UIStoryboardSegue){
        
    }
    

//    @IBAction func sideMenuButton(_ sender: Any) {
//        if (isSideMenuShowing){
//            sideMenu.constraints = -140
//        }
//    }
    
    @IBAction func sideMenuButton(_ sender: Any) {
    
        if (isSideMenuShowing){
            sideMenuLeadingConstraint.constant = 0

        }else{
            sideMenuLeadingConstraint.constant = -140
        }

        isSideMenuShowing = !isSideMenuShowing
    }

}
