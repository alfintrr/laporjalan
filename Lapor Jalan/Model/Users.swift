//
//  Users.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 06/06/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import FirebaseFirestore


class Users{
    var db: Firestore!
//    let id = String()
//    var nomorhp = String()
//    var username = String()
//    var password = String()
//

    
    func dbConnection(){
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func uploadToFirebase(id: String, nomorHp: String, username: String, password: String) -> String{
        dbConnection()
        db.collection("pengguna").document(username).setData(["id": id, "nomorHp": nomorHp, "username": username, "password": password]) {err in
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                print("Document successfully written!")
                
            }
        }
        return ""
    }
    
}

