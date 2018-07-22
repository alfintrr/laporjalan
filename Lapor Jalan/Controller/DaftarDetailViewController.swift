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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmTF: UITextField!
    
    
    @IBAction func daftarButton(_ sender: Any) {
                aksesAkun()
        let username = (usernameTF.text)!
        let password = (passwordConfirmTF.text)!
        
        print(self.id)
        print(self.nomorHp)
        
        let users = Users()
        users.uploadToFirebase(id: self.id, nomorHp: self.nomorHp, username: username, password: password)
        
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    @IBAction func logout(_ sender: UIButton) {}
//    func logout(){
//        accountKit.logOut()
//        dismiss(animated: true, completion: nil)
//        print("logged out")
//    }
    
}
