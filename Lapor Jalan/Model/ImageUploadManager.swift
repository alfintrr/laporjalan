//
//  ImageUploadManager.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 19/09/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

struct Constants{ //ini apa?
    struct Lubang {
        static let imagesFolder: String = "gambarLubang"

    }
}

class ImageUploadManager{
    
    func uploadImage(_ image: UIImage, progressBlock: @escaping (_ percentage: Float) -> Void, completionBlock: @escaping (_ url: URL?, _ errorMessage: String?) -> Void) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        // storage/carImages/image.jpg
        let imageName = "\(Date().timeIntervalSince1970).jpg"
        let imagesReference = storageReference.child(Constants.Lubang.imagesFolder).child(imageName)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = imagesReference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
                if let metadata = metadata {
                    imagesReference.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            print("couldn't get profile image url")
                            return
                        }
                    }
                } else {
                    completionBlock(nil, error?.localizedDescription)
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
//    func uploadImage(_ image: UIImage, progressBlock: @escaping (_ percentage: Double) -> Void, completionBlock: @escaping (_ url: URL?, _ errorMessage: String?) -> Void) {
//        let storage = Storage.storage()
//        let storageReference = storage.reference()
//
//        // storage/carImages/image.jpg
//        let imageName = "\(Date().timeIntervalSince1970).jpg"
//        let imagesReference = storageReference.child(Constants.Lubang.imagesFolder).child(imageName)
//
//        if let imageData = UIImageJPEGRepresentation(image, 0.8) {
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpeg"
//
//            let uploadTask = imagesReference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
//                if let metadata = metadata {
//                    completionBlock(imagesReference.downloadURL(completion: <#T##(URL?, Error?) -> Void#>))
//
//                    }
//                }else {
//                    completionBlock(nil, error?.localizedDescription)
//                }
//            })
//            uploadTask.observe(.progress, handler: { (snapshot) in
//                guard let progress = snapshot.progress else {
//                    return
//                }
//
//                let percentage = (Double(progress.completedUnitCount) / Double(progress.totalUnitCount)) * 100
//                progressBlock(percentage)
//            })
//        } else {
//            completionBlock(nil, "Image couldn't be converted to Data.")
//        }
//}
}
