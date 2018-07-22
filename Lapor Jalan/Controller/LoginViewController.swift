//
//  LoginViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 24/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "status")
        Switcher.updateRootVC()
    }
    
}
