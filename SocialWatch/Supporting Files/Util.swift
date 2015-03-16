//
//  Util.swift
//  SocialWatch
//
//  Created by Francisco Caro Diaz on 09/03/15.
//  Copyright (c) 2015 AreQua. All rights reserved.
//

import Foundation

class Util {
    
    class func showMessage(title: String, message: String) -> UIAlertController {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        return alertController
        
    }
    
}
