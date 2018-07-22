//
//  Switcher.swift
//  Lapor Jalan
//
//  Created by Alfin Taufiqurrahman on 14/07/18.
//  Copyright © 2018 Alfin Taufiqurrahman. All rights reserved.
//

import Foundation
import UIKit

class Switcher{
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        
        if(status == true){
            rootVC = UIStoryboard(name: "Awal", bundle: nil).instantiateViewController(withIdentifier: "lapor") as! LaporViewController
        }else{
            rootVC = UIStoryboard(name: "Awal", bundle: nil).instantiateViewController(withIdentifier: "begin") as! AwalViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
