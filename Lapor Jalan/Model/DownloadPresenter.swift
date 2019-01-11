//
//  DownloadPresenter.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 10/11/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DownloadPresenter: NSObject, UITableViewDelegate{
    private var listener: ListenerRegistration?
    //let dataSource: DataSource!
    private weak var dataSource: DataSource?
    

        init(dataSource: DataSource?){
            self.dataSource = dataSource
        }    
    
    private func baseQuery() -> Query{
        //limit bisa dihapus
        return Firestore.firestore().collection("laporan").limit(to: 50)
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
                self.dataSource?.laporanToDisplay = snapshot.documents.compactMap({ (document) -> Laporan? in
                    return Laporan(dictionary: document.data(), objectID: document.documentID)
                    
                })
                print("datasource fetch laporan")
                completion(nil)
            }
        })
    }
}
