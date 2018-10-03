//
//  MenuViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 11/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

//G-API AIzaSyCKDDxMrCsScDGvdTUpJJkvUUE9puuzEtM

import UIKit
import Foundation
import CoreLocation
import GooglePlaces
import GoogleMaps
import Firebase
import FirebaseFirestore
import AccountKit

class LaporViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var db: Firestore!
    var lokasi = String()
    let ukuran = ["kecil","sedang", "besar", "sangat besar"]
    var ukuranTerpilih: String?
    var tanggal = String()
    var accountKit: AKFAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kameraTap()
        lokasiTap()
        timestamp()
        ukuranLubang()
        buatToolbar()
//        lokasiSayaLabel.text = "Lokasi Saya"
//        if lokasi != "" {
//            print (lokasi)
//            lokasiSayaTextField.text = lokasi
//        }
        
//        ukuranPickerView.isHidden = true
//        ukuranPickerView.delegate = self
//        ukuranPickerView.dataSource = self
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        
        //hide the keyboard, tap dimana saja
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }


    @IBOutlet weak var lokasiSayaTextField: UITextField!
    
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    //coba kamera tap
    func kameraTap(){
        
        let tapKamera = UITapGestureRecognizer(target: self, action: #selector(self.openTheCamera))
        imagePicked.isUserInteractionEnabled = true
        imagePicked.addGestureRecognizer(tapKamera)
                print("camera running")
    }
    
    //lokasi tap
    func lokasiTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapLokasi))
        lokasiSayaTextField.isUserInteractionEnabled = true
        lokasiSayaTextField.addGestureRecognizer(tap)
    }
    @objc func tapLokasi(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "openMap", sender: nil)
        print("map tap")
    }
    
    //kirim data dari map
    @IBAction func unwindFromMapView(_ sender: UIStoryboardSegue){
        lokasiSayaTextField.text = "Lokasi Saya"
        if lokasi != "" {
            print(lokasi)
            lokasiSayaTextField.text = lokasi
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openMap"{
            let mapViewController = segue.destination as! MapViewController
        mapViewController.title = "Lokasi"
        }
    }
    
    //timestamp
    func timestamp() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: now)
        tanggal = dateString
        print("***********************T I M E************************")
        print(dateString)
        print("***********************T I M E************************")
    }
    
    //kamera
@objc func openTheCamera(sender: UITapGestureRecognizer){
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        print("kameraaaaa")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated:true, completion: nil)
        
        guard let imageToUpload = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        imagePicked.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        print("----camera sukses----")
    }
    
    @IBOutlet weak var deskripsiTextField: UITextField!
    
    @IBOutlet weak var ukuranLubangTextField: UITextField!
    
    func ukuranLubang(){
            let ukuranPicker = UIPickerView()
        ukuranPicker.delegate = self
        
        ukuranLubangTextField.inputView = ukuranPicker
        
        ukuranPicker.backgroundColor = .white
    }
    
    func buatToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        ukuranLubangTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
//    @IBAction func openPhotoLibraryButton(_ sender: UIButton) {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary;
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
//
//    @IBAction func saveButton(_ sender: UIButton) {
//        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 1.0)
//        let compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
//
//    }
    
    func uploadImage(){
        
    }
    
    private func kirimSemua(){
        db.collection("cities").document("laporan").setData(["username": "alfintaufiq", "date": tanggal, "image": UIImagePickerControllerOriginalImage, "lokasi": lokasi, "deskripsi": "deskripsi"]) {err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
        }
    }
    
    @IBAction func kirimButton(_ sender: Any) {
        //TODO: post to firebase
        let laporan = Laporan()
        kirimSemua()
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
        performSegue(withIdentifier: "backToBegin", sender: self)
        //let logout = AwalViewController()
        //logout.logOut()
        //UserDefaults.standard.set(false, forKey: "status")
        //Switcher.updateRootVC()
        //        let fungsiLogout = AwalViewController()
//        fungsiLogout.logout()
    }
}

extension LaporViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return ukuran.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ukuran[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //ukuranButton.setTitle(ukuran[row], for: .normal)
        ukuranTerpilih = ukuran[row]
        ukuranLubangTextField.text = ukuranTerpilih
        
    }
    
   
}
