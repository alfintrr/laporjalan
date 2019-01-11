//
//  StarterViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 11/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import AccountKit

class DaftarDetailViewController: UIViewController {
    
    var emailTest = ""
    var passTest = ""
    var passCoTest = ""
    
    @IBOutlet weak var daftarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        setDaftarButton(enabled: false)
        
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordConfirmTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmTF: UITextField!
    
    @IBAction func daftarButton(_ sender: Any) {
        
        daftarAction()
        
    }
    
    func daftarAction(){
        //UJI
//        print(emailTest)
//        print(passTest)
//        print(passCoTest)
//        let email = emailTest
//        let password = passTest
//        let passwordConfirm = passCoTest
        
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        guard let passwordConfirm = passwordConfirmTF.text else {return}
        
        print(email)
        
        if (password == passwordConfirm){
         
            print("if jalan")
            let user = Users()
            print(email)
            user.signUpToFirebase(email: email, pass: password, completionBlock: { [unowned self] (email, errorMessage) in
                if email != nil{
                    print("signed up")
                    print("terdaftar")
                    self.signedUp()
                    
                }else{
                    let alert = UIAlertController(title: "Kesalahan!!", message: "Email telah terdaftar", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in
                        
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion:nil)
                }
                
                //self.signedUp()
                }
            )
        }else{
            let alert = UIAlertController(title: "Kesalahan!!", message: "Password dan Konfirmasi Password Berbeda", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) -> Void in
                print("password berbeda")
            }
            alert.addAction(okAction)
             self.present(alert, animated: true, completion:nil)
        }
        
       
    }
    
    func signedUp(){
        self.performSegue(withIdentifier: "daftarToMenu", sender: self)
        //self.dismiss(animated: false, completion: nil)
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTF.text
        let password = passwordTF.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setDaftarButton(enabled: formFilled)
    }
    
    func setDaftarButton(enabled: Bool){
        if enabled{
            daftarButton.alpha = 1.0
            daftarButton.isEnabled = true
        }else{
            daftarButton.alpha = 0.5
            daftarButton.isEnabled = false
        }
    }
    
}
