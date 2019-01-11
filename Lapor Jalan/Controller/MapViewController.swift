//
//  MapViewController.swift
//
//
/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// Modified by Alfin Taufiqurrahman 2018

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
 
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapCenterPinImage: UIImageView!
    
    @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    var lat = Double()
    var long = Double()
    var thoroughfare = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        
    }

    //Exit a.k.a Save / unwind
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let laporController = segue.destination as! LaporAdminViewController
        if addressLabel.text != "" {
            laporController.lokasi = addressLabel.text!
            laporController.lat = lat
            laporController.long = long
            laporController.thoroughfare = thoroughfare
        }
        
    }
    
}

// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
    }
    
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        self.addressLabel.unlock()
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            // 3
        
            let roadName = address.thoroughfare!
            if let road = roadName.range(of: "Jalan")?.lowerBound {
                let substring = roadName[..<road]
                let string = String(substring)
                self.thoroughfare = roadName.replacingOccurrences(of: string, with: "")
               // print(replaced)  // "ora"
            }
            self.lat = address.coordinate.latitude
            self.long = address.coordinate.longitude
            self.addressLabel.text = lines.joined(separator: "\n")
            
            // 1
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            if #available(iOS 11.0, *) {
                self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                                    bottom: labelHeight, right: 0)
            } else {
                // Fallback on earlier versions
            }
            
            // 4
            UIView.animate(withDuration: 0.25) {
                if #available(iOS 11.0, *) {
                    self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * -1)
                } else {
                    // Fallback on earlier versions
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
    }
}
