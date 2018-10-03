//
//  RiwayatViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 25/04/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import Firebase

//MARK: -Search
class RiwayatViewController: UIViewController {
    var db: Firestore!
    let laporan = ["laporan1","laporan2","laporan3","laporan4","laporan5","laporan6","laporan7","laporan8","laporan9","laporan10","laporan11","laporan12"]
    var myIndex = 0
    
    @IBOutlet weak var tanggalAwalTextField: UITextField!
    @IBOutlet weak var tanggalAkhirTextField: UITextField!
    @IBOutlet weak var setTanggalButton: UIButton!
    
    let datePickerAwal = UIDatePicker()
    let datePickerAkhir = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatepicker()
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        //simpleQueries()
        
        setTanggalButton.layer.cornerRadius = 10
    }
    
    func createDatepicker(){
        
        //format datepicker
        datePickerAwal.datePickerMode = .date
        datePickerAkhir.datePickerMode = .date
        
        //assign datepicker ke textfield
        tanggalAwalTextField.inputView = datePickerAwal
        tanggalAkhirTextField.inputView = datePickerAkhir
        
        //buat toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button ditoolbar
        let doneButtotn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButtotn], animated: true)
        tanggalAwalTextField.inputAccessoryView = toolbar
        tanggalAkhirTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        //format di textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        tanggalAwalTextField.text = dateFormatter.string(from: datePickerAwal.date)
        tanggalAkhirTextField.text = dateFormatter.string(from: datePickerAkhir.date)
        self.view.endEditing(true)
    }
    
    //tap set tanggal
    func setTanggalTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapTanggal))
        setTanggalButton.isUserInteractionEnabled = true
        setTanggalButton.addGestureRecognizer(tap)
    }
    @objc func tapTanggal(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "setTanggal", sender: nil)
        print("tanggal diset")
    }
    
    
    
    //GET
//    private func simpleQueries() {
//    let docRef = db.collection("cities").document("laporan")
//
//        docRef.getDocument { (document, error) in
//        if let document = document, document.exists {
//            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//            print("Document data: \(dataDescription)")
//        } else {
//            print("Document does not exist")
//        }
//        }
//    }
}


//MARK: -TableView
extension RiwayatViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(laporan.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = laporan[indexPath.row]
        
        return(cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "laporanTunggal", sender: self)
    }
}
