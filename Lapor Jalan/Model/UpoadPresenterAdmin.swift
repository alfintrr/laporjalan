//
//  UpoadLaporanAdmin.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 02/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UploadPresenterAdmin: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var getDownloadURL = ImageUploadManagerAdmin()
    let laporView = LaporAdminViewController()
    
    private weak var viewController: LaporAdminViewController?
    private let imageUploadManager = ImageUploadManagerAdmin()
    
    private let collection = Firestore.firestore().collection("laporanAdmin")
    
    init(viewController: LaporAdminViewController?) {
        self.viewController = viewController
    }
    
    // MARK: Uploading content
    func uploadLaporan(withImage image: UIImage, email: String, tanggal: String, lokasi: String, lat: Double, long: Double, thoroughfare: String, deskripsi: String, completionBlock: @escaping (_ errorMessage: String?) -> Void){
        
        imageUploadManager.uploadImage(image, progressBlock: { [unowned self] (percentage) in
            print(percentage)
            }, completionBlock: { [unowned self] (downloadURL, errorMessage) in
                print("ini berjalan")
                if let fileURL = downloadURL {
                    // 3. create the car object with the image url
                    self.uploadLaporan(email: email, tanggal: tanggal, lokasi: lokasi, lat: lat, long: long, thoroughfare: thoroughfare, deskripsi: deskripsi, imageURL: fileURL.absoluteString, completionBlock: { [unowned self] (errorMessage) in
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
    
    private func uploadLaporan(email: String, tanggal: String, lokasi: String, lat: Double, long: Double, thoroughfare: String, deskripsi: String, imageURL: String, completionBlock: @escaping (_ errorMessage: String?) -> Void) {
        let laporan = LaporanAdmin(objectID: nil, email: email, tanggal: tanggal, lokasi: lokasi, lat: lat, long: long, thoroughfare: thoroughfare, deskripsi: deskripsi, imageURL: imageURL)
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
