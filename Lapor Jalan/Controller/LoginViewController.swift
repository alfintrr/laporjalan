//
//  LoginViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 24/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var activityView:UIActivityIndicatorView!
    
    var emailTest = ""
    var passTest = ""
    
    override func viewDidLoad() {
        setLoginButton(enabled: false)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(_ sender: Any) {
        
        loginAction()
    }
    
    func loginAction(){
        //UJI
//        let email = emailTest
//        let password = passTest
        
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        let user = Users()
        user.signInWithEmail(email: email, pass: password, completionBlock: { [unowned self] (email, errorMessage) in
            if email != nil{
                print("signed in")
                print("SUKSES")
                if email == "admin@gmail.com"{
                    self.signedInAsAdmin()
                }else{
                    self.signedIn()
                }
            }else{
                print("GAGAL")
                let alert = UIAlertController(title: "Kesalahan!!", message: "Email atau password tidak terdaftar", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in
                    
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion:nil)
            }
        } )
    }
    

    func signedIn(){
        self.performSegue(withIdentifier: "loginToMenu", sender: self)
    }
    
    func signedInAsAdmin(){
        self.performSegue(withIdentifier: "adminLoginToMenu", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTF.text
        let password = passwordTF.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButton(enabled: formFilled)
    }
    
    func setLoginButton(enabled: Bool){
        if enabled{
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        }else{
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    
}



