//
//  SekitarViewController.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 07/12/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import GoogleMaps

class MapRiwayatViewController: UIViewController{
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var lat = Double()
    var long = Double()
    var detailRiwayat = DetailRiwayatViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let marker = GMSMarker(position: position)
        marker.map = mapView
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 16)
        mapView.camera = camera
        print("MAP SUKSES")
    }
    
}
