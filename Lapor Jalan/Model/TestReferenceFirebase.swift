//
//  TestreferencceFirebase.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 01/10/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import Firebase

class TestReferenceFirebase{
    
    // Points to the root reference
    let storageRef = Storage.storage().reference()
    
    // Points to "images"
    let imagesRef = storageRef.child("images")
    
    init(){
        self.imagesRef
    }
    
    // Points to "images/space.jpg"
    // Note that you can use variables to create child values
    let fileName = "space.jpg"
    let spaceRef = imagesRef.child(fileName)
    
    // File path is "images/space.jpg"
    let path = spaceRef.fullPath;
    
    // File name is "space.jpg"
    let name = spaceRef.name;
    
    // Points to "images"
    let images = spaceRef.parent()
    
    init(){
        self.imagesRef =
    }
}

