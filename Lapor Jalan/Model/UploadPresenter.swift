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
    
    private weak var viewController: LaporViewController?
    private let imageUploadManager = ImageUploadManager()
    
    private let collection = Firestore.firestore().collection("cars")
    
    init(viewController: LaporViewController?) {
        self.viewController = viewController
    }
    
    // MARK: Image picker
    func showImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        viewController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            
            //viewController?.userSelectedImage(image)
        }
    }
    
    // MARK: Uploading content
    func createCar(withImage image: UIImage, title: String, price: Int) {
        // 1. show the uploading state
        viewController?.showUploadingState(true)
        // 2. upload the image
        imageUploadManager.uploadImage(image, progressBlock: { [unowned self] (percentage) in
            print(percentage)
            self.viewController?.updateProgressView(with: percentage)
            }, completionBlock: { [unowned self] (fileURL, errorMessage) in
                if let fileURL = fileURL {
                    // 3. create the car object with the image url
                    self.createCar(title: title, price: price, imageURL: fileURL.absoluteString)
                } else {
                    // TODO: error handling
                    if let error = errorMessage {
                        self.viewController?.handleError(error)
                    }
                }
        })
    }
    
    private func createCar(title: String, price: Int, imageURL: String) {
        let car = Car(objectID: nil, name: title, price: NSNumber(value: price), imageURL: imageURL)
        collection.addDocument(data: car.dictionary()) { [unowned self] (error) in
            if let error = error {
                self.viewController?.handleError(error.localizedDescription)
            } else {
                self.viewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
