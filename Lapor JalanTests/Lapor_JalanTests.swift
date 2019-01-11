//
//  Lapor_JalanTests.swift
//  Lapor JalanTests
//
//  Created by Alfin Taufiqurrahman on 13/12/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import UIKit
import XCTest

@testable import Lapor_Jalan

class Lapor_JalanTests: XCTestCase {

    let daftar = DaftarDetailViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        daftar.emailTF.text = "userTest@gmail.com"
//        daftar.passwordTF.text = "12345678"
//        daftar.passwordConfirmTF.text = "12345678"
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      
    }
    


    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testDaftar(){
        
        
      
//
//        let email = "userTest@gmail.com"
//        let password = "12345678"
//        let passwordConfirm = "12345678"
//        daftar.daftarAction(email: "dhfjafkjasjkdajks@gmail.com", password: "12345678", passwordConfirm: "12345678")
        daftar.viewDidLoad()
        daftar.emailTF.text = "userTest@gmail.com"
        daftar.passwordTF.text = "12345678"
        daftar.passwordConfirmTF.text = "12345678"
        daftar.daftarAction()
        
        
//        XCTAssertEqual(coba, nil)
        
    }
    
    func testDetailRiwayat(for segue: UIStoryboardSegue, sender: Any?){
        let  lat = -7.942785
        let  long = 112.621217
        
        let testMap = segue.destination as! MapRiwayatViewController
        
        testMap.lat = lat
        
        testMap.long = long
    }
    
    func testKirim(){
        let lapor = LaporViewController()
        lapor.email = "user@gmail.com"
        lapor.kirimSemua()
    }
    
    func mapRiwayatTest(){
        let riwayat = MapRiwayatViewController()
        riwayat.viewDidLoad()
    }
    
    func testPrepare(for segue: UIStoryboardSegue, sender: Any?){
        let  lat = -7.942785
        let  long = 112.621217
        
        let testMap = segue.destination as! MapRiwayatViewController
        
        testMap.lat = lat
        
        testMap.long = long
    }


}
