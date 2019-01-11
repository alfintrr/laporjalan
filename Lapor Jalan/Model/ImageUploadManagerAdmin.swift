//
//  ImageUploadPresenterAdmin.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

struct Constantss{
    struct Lubang {
        static let imagesFolder: String = "gambarLubangSelesai"
        
    }
}

class ImageUploadManagerAdmin: NSObject{
    
    func uploadImage(_ image: UIImage, progressBlock: @escaping (_ percentage: Float) -> Void, completionBlock: @escaping (_ url: URL?, _ errorMessage: String?) -> Void) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        // storage/carImages/image.jpg
        let imageName = "\(Date().timeIntervalSince1970).jpg"
        let imagesReference = storageReference.child(Constantss.Lubang.imagesFolder).child(imageName)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = imagesReference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
                imagesReference.downloadURL { (url, error) in
                    if let error = error {
                        completionBlock(nil, error.localizedDescription)
                    }else{
                        guard let downloadURL = url else {
                            print("couldn't get profile image url")
                            return
                        }
                        completionBlock(downloadURL, nil)
                        print(downloadURL)
                    }
                }
            })
            uploadTask.observe(.progress, handler: { (snapshot) in
                guard let progress = snapshot.progress else {
                    return
                }
                
                let percentage = (Float(progress.completedUnitCount) / Float(progress.totalUnitCount)) * 100
                progressBlock(percentage)
            })
        } else {
            completionBlock(nil, "Image couldn't be converted to Data.")
        }
    }
}
