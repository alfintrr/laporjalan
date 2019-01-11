//
//  ViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 04/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import AccountKit
import Firebase

class AwalViewController: UIViewController, AKFViewControllerDelegate {
    
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var logIn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if (Auth.auth().currentUser != nil) {
            if (Auth.auth().currentUser?.email == "admin@gmail.com"){
                self.performSegue(withIdentifier: "goToAdmin", sender: self)
            }
            else{
                self.performSegue(withIdentifier: "goToMenu", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//    @IBAction func loginWithPhone(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToDaftar", sender: self)
//    }
}

