//
//  ViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 04/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import AccountKit

class AwalViewController: UIViewController, AKFViewControllerDelegate {
    
    var id: String = ""
    
    var accountKit: AKFAccountKit!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Init Account Kit
        if accountKit == nil{
            self.accountKit = AKFAccountKit(responseType: .accessToken)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (accountKit.currentAccessToken != nil){
            print("data user ada")
            print(accountKit.currentAccessToken)
            DispatchQueue.main.async(execute: {
                self.performSegue(withIdentifier: "goToMenu", sender: self)
            })
        }
        
    }
    
    func prepareViewController(_ ViewController: AKFViewController){
        ViewController.delegate = self
        ViewController.setAdvancedUIManager(nil)
        ViewController.whitelistedCountryCodes = ["ID"]
        
        //Customize the theme
        let theme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        ViewController.setTheme(theme)
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
  

    @IBAction func loginWithPhone(_ sender: UIButton) {
        //login with phone
        let inputState = UUID().uuidString
        let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareViewController(viewController)
        self.present(DaftarDetailViewController.self as! UIViewController, animated: true, completion: nil)
        
    }
    
    func logout(){
        print(accountKit.currentAccessToken as Any)
        accountKit.logOut()
        dismiss(animated: true, completion: nil)
        print("logged out")
    }
}

