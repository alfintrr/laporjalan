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
    
    var accountKit: AKFAccountKit!
    var id: String = ""
    var nomorHp: String = ""
    @IBOutlet weak var daftarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daftarButton.layer.cornerRadius = 100
        daftarButton.clipsToBounds = true
        
        //init Account Kit
        
        //        self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        //        accountKit.requestAccount({
        //            (account, error) -> Void in
        //            self.accountID.text = account?.accountID
        //
        //            if account?.phoneNumber?.phoneNumber != nil{
        //                self.nomor.text = account!.phoneNumber?.stringRepresentation()
        //
        //            }
        //        })
        
    }
    
    func aksesAkun(){
        self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        accountKit.requestAccount({
            (account, error) in
            self.id = (account?.accountID)!
            self.nomorHp = (account!.phoneNumber?.stringRepresentation())!
        })
    }
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func daftarButton(_ sender: Any) {
                //aksesAkun()
        guard let email = emailTF.text else {return}
        guard let username = usernameTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        setDaftarButton(enabled: true)
        
        print(self.id)
        print(self.nomorHp)
        
        let users = Users()
        users.uploadToFirebase(email: email, pass: password)
        
        //users.uploadToFirebase(id: self.id, nomorHp: self.nomorHp, username: username, password: password)
        
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    func setDaftarButton(enabled: Bool){
        if enabled{
            daftarButton.alpha = 1.0
            daftarButton.isEnabled = true
        }else{
            daftarButton.alpha = 1.0
            daftarButton.isEnabled = false
        }
    }
    

    func logout(){
       accountKit.logOut()
        dismiss(animated: true, completion: nil)
        print("logged out")
    }
    
}
