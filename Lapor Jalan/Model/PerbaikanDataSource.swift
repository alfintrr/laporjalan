//
//  PerbaikanDataSource.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 03/01/19.
//  Copyright © 2019 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import FirebaseFirestore

class PerbaikanDataSource: NSObject, UICollectionViewDataSource {
    
    var laporanToDisplay: [Any] = []
    
    private var listener: ListenerRegistration?
    
    private func baseQuery() -> Query{
        //limit bisa dihapus
        return Firestore.firestore().collection("laporanAdmin").order(by: "tanggal", descending: true).limit(to: 100)
    }
    
    func fetchLaporan(_ completion: @escaping (_ error: String?) -> Void){
        listener = baseQuery().addSnapshotListener({ [unowned self] (snapshot, error) in
            if let error = error {
                completion(error.localizedDescription)
                print("datasource error 1")
            }else{
                guard let snapshot = snapshot else {
                    completion(nil)
                    print("datasource error 2")
                    return
                }
                self.laporanToDisplay = snapshot.documents.compactMap({ (document) -> LaporanAdmin? in
                    return LaporanAdmin(dictionary: document.data(), objectID: document.documentID)
                    
                })
                print("datasource fetch laporan")
                completion(nil)
            }
        })
    }
    
    //    func stopObsereveQuery(){
    //        listener?.remove()
    //    }
    
    func itemAt(_ indexPath: IndexPath) -> Any {
        return laporanToDisplay[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return laporanToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = laporanToDisplay[indexPath.item]
        if let laporan = item as? LaporanAdmin {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PerbaikanCollectionViewCell
            cell.fillWith(laporan)
            print("fillwith jalan")
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PerbaikanCollectionViewCell
            print("else fillwith")
            return cell
        }
    }
    
}
