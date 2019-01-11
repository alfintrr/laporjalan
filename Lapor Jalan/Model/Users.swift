//
//  Users.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 06/06/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import Firebase


class Users{
    
//    var signInStatus = false
//    var SignUpStatus = false
    
    func signInWithEmail(email: String, pass:  String, completionBlock: @escaping (_ user: String?, _ errorMessage: String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil{
                print("signed in")
                completionBlock(email, nil)

            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
                completionBlock(nil, error as? String)
            }
        }
    }
    
//    func signInWithEmail(email: String, pass:  String, completionBlock: @escaping (_ user: String?, _ errorMessage: String?) -> Void){
//        do{
//            try Auth.auth().signIn(withEmail: email, password: pass)
//        } catch let signUpError as NSError {
//
//        }
//    }
    
    func signUpToFirebase(email: String, pass: String, completionBlock: @escaping (_ user: String?, _ errorMessage: String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: pass) {user, error in
            if error == nil && user != nil{
                print("user created")
                completionBlock(email, nil)

            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
                completionBlock(nil, error?.localizedDescription)
            }
        }
    }
    
    func logOut(completionBlock: @escaping (_ errorMessage: String?) -> Void){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("sukses signout")
            completionBlock(nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
    }
}
