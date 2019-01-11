//
//  Laporan.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 07/06/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

    import UIKit
    
    struct Laporan {
        
        var objectID: String!
        var email: String!
        var tanggal: String!
        var image: UIImage?
        var imageURL: String!
        var lokasi: String!
        var lat: Double!
        var long: Double!
        var thoroughfare: String!
        var deskripsi: String!
        var kerusakan: String!
        var status: String!
        var level: Int!
        
        init?(dictionary: [String: Any]?, objectID: String) {
            guard let dictionary = dictionary,
                let email = dictionary["email"] as? String,
                let tanggal = dictionary["tanggal"] as? String,
                let lokasi = dictionary["lokasi"] as? String,
                let lat = dictionary["lat"] as? Double,
                let long = dictionary["long"] as? Double,
                let thoroughfare = dictionary["thoroughfare"] as? String,
                let deskripsi = dictionary["deskripsi"] as? String,
                let kerusakan = dictionary["kerusakan"] as? String,
                let status = dictionary["status"] as? String,
                let level = dictionary["level"] as? Int,
                let imageURL = dictionary["imageURL"] as? String else {
                    return nil
            }
            
            self.init(objectID: objectID, email: email, tanggal: tanggal, lokasi: lokasi, lat: lat, long: long, thoroughfare: thoroughfare, deskripsi: deskripsi, kerusakan: kerusakan, status: status, level: level, imageURL: imageURL)
        }
        
        init(objectID: String?, email: String, tanggal: String, lokasi: String, lat: Double, long: Double, thoroughfare: String, deskripsi: String, kerusakan: String, status: String, level: Int, imageURL: String) {
            self.objectID = objectID ?? ""
            self.email = email
            self.tanggal = tanggal
            self.lokasi = lokasi
            self.lat = lat
            self.long = long
            self.thoroughfare = thoroughfare
            self.deskripsi = deskripsi
            self.kerusakan = kerusakan
            self.status = status
            self.level = level
            self.imageURL = imageURL
        }
        
        func dictionary() -> [String: Any] {
            return ["email": email, "tanggal": tanggal, "lokasi": lokasi, "lat": lat, "long": long, "thoroughfare": thoroughfare, "deskripsi": deskripsi, "kerusakan": kerusakan, "status": status, "level": level, "imageURL": imageURL]
        }
        
    }
