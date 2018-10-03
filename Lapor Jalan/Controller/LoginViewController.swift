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
        //UserDefaults.standard.set(true, forKey: "status")
//        Switcher.updateRootVC()
        handleSignIn()
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTF.text
        let password = passwordTF.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLoginButton(enabled: formFilled)
    }
    
    
    

    @objc func handleSignIn(){
        guard let email = emailTF.text else { return}
        guard let pass = passwordTF.text else { return}

        activityView.startAnimating()

        Auth.auth().signIn(withEmail: email, password: pass){ user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            }else{
                print("Error logging in: \(error?.localizedDescription)")
            }
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case emailTF:
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
            break
        case passwordTF:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    
}


