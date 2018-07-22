//
//  Laporan.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 07/06/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Laporan{
    var db: Firestore!
    
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
    
    //MARK: -upload image to storage the catch the url
    
//    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
//        let storageRef = FIRStorage.storage().reference().child("myImage.png")
//        if let uploadData = UIImagePNGRepresentation(self.myImageView.image!) {
//            storageRef.put(uploadData, metadata: nil) { (metadata, error) in
//                if error != nil {
//                    print("error")
//                    completion(nil)
//                } else {
//                    completion((metadata?.downloadURL()?.absoluteString)!))
//                    // your uploaded photo url.
//                }
//            }
//        }
//
//        func kirim(){
//        if self.titleText.text   != "" && self.authorText.text != ""
//            && self.mainText.text != "" && self.dateText.text   != "" {
//
//            uploadMedia() { url in
//                if url != nil {
//                    ref?.child("Posts").childByAutoId().setValue([
//                        "Title"      : titleText.text,
//                        "Article"    : mainText.text,
//                        "Author"     : authorText.text,
//                        "Date"       : dateText.text,
//                        "myImageURL" : url!
//                        ])
//                }
//            }
//        }
//        }
    
//    private func kirimSemua(){
//        db.collection("cities").document("laporan").setData(["username": "alfintaufiq", "date": tanggal, "image": UIImagePickerControllerOriginalImage, "lokasi": lokasi, "deskripsi": "deskripsi"]) {err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//    }
    
    
}
