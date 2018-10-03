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
    
    
    var id: String = ""
    var accountKit: AKFAccountKit!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
       register.layer.cornerRadius = 100
        register.clipsToBounds = true
        
        logIn.layer.cornerRadius = 100
        logIn.clipsToBounds = true
        
        //Init Account Kit
        if accountKit == nil{
            self.accountKit = AKFAccountKit(responseType: .accessToken)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "goToMenu", sender: self)
        }
        
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if (accountKit.currentAccessToken != nil){
//            print("data user ada")
//            DispatchQueue.main.async(execute: {
//                self.performSegue(withIdentifier: "goToMenu", sender: self)
//            })
//        }
////        else{
////            DispatchQueue.main.async(execute: {
////                self.performSegue(withIdentifier: "goToDaftar", sender: self)
////            })
////
////        }
//
//    }
    
    func prepareDaftarDetailViewController(_ DaftarDetailViewController: AKFViewController){
        DaftarDetailViewController.delegate = self
        DaftarDetailViewController.setAdvancedUIManager(nil)
        DaftarDetailViewController.whitelistedCountryCodes = ["ID"]
        
        //Customize the theme
        let theme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        DaftarDetailViewController.setTheme(theme)
    }

    @IBAction func loginWithPhone(_ sender: UIButton) {
        //login with phone
        let inputState = UUID().uuidString
        let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareDaftarDetailViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
        performSegue(withIdentifier: "goToDaftar", sender: self)
        
    }
    
    func logOut(){
        accountKit.logOut()
        dismiss(animated: true, completion: nil)
        print("logged out")
    }
}

