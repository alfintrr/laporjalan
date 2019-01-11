//
//  UploadPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 01/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation

//
//  UploadPresenter.swift
//  GridLayout
//
//  Created by Sztanyi Szabolcs on 2017. 11. 12..
//  Copyright © 2017. Sabminder. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UploadPresenter: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var getDownloadURL = ImageUploadManager()
    let laporView = LaporViewController()
    
    private weak var viewController: LaporViewController?
    private let imageUploadManager = ImageUploadManager()
    
    private let collection = Firestore.firestore().collection("laporan")
    
    init(viewController: LaporViewController?) {
        self.viewController = viewController
    }
    
    // MARK: Uploading content
    func uploadLaporan(withImage image: UIImage, email: String, tanggal: String, lokasi: String, lat: Double, long: Double, thoroughfare: String, deskripsi: String, kerusakan: String, status: String, level: Int, completionBlock: @escaping (_ errorMessage: String?) -> Void){

        imageUploadManager.uploadImage(image, progressBlock: { [unowned self] (percentage) in
            print(percentage)
            }, completionBlock: { [unowned self] (downloadURL, errorMessage) in
                print("ini berjalan")
                if let fileURL = downloadURL {
                    // 3. create the car object with the image url
                    self.uploadLaporan(email: email, tanggal: tanggal, lokasi: lokasi, lat: lat, long: long, thoroughfare: thoroughfare, deskripsi: deskripsi, kerusakan: kerusakan, status: status, level: level, imageURL: fileURL.absoluteString, completionBlock: { [unowned self] (errorMessage) in
                        if errorMessage == nil{
//                            print("signed in")
                            completionBlock(nil)
                        }
//                        else{
//                            print("Error: \(errorMessage?.localizedDescription)")
//                            completionBlock(error?.localizedDescription)
//                        }
                    
                    })
                    
                } else {
                    // TODO: error handling
                    if let error = errorMessage {
                        self.viewController?.handleError(error)
                    }
                }
        })
    }
    
    private func uploadLaporan(email: String, tanggal: String, lokasi: String, lat: Double, long: Double, thoroughfare: String, deskripsi: String, kerusakan: String, status: String, level: Int, imageURL: String, completionBlock: @escaping (_ errorMessage: String?) -> Void) {
        let laporan = Laporan(objectID: nil, email: email, tanggal: tanggal, lokasi: lokasi, lat: lat, long: long, thoroughfare: thoroughfare, deskripsi: deskripsi, kerusakan: kerusakan, status: status, level: level, imageURL: imageURL)
        collection.addDocument(data: laporan.dictionary()) { [unowned self] (error) in
            if error == nil{
                print("uploaded")
                completionBlock(nil)
                
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
                completionBlock(error?.localizedDescription)
            }
            //            if let error = error {
//                self.viewController?.handleError(error.localizedDescription)
//            } else {
//                //self.viewController?.dismiss(animated: true, completion: nil)
//
//                //pannggil fungsi clear semua field
//                self.laporView.callDismissAlert()
//                print("indicator should end")
//            }
        }
    }
    
}
