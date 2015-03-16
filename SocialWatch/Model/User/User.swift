//
//  User.swift
//  SocialWatch
//
//  Created by Francisco Caro Diaz on 09/03/15.
//  Copyright (c) 2015 AreQua. All rights reserved.
//

import Foundation
import UIKit

class User {
    var userID:AnyObject = "";
    var userIDFB:AnyObject = "";
    var userIDG:AnyObject = "";
    var nickName:AnyObject = "";
    var email:AnyObject = "";
    var fullName:AnyObject = "";
    var country:AnyObject = "";
    var gender:AnyObject = "";
    var picture:AnyObject = "";
    
    init(){}
    
    init(userID:AnyObject, nickName:AnyObject, email:AnyObject, gender:AnyObject, picture:AnyObject){
        self.userID = userID
        self.nickName = nickName
        self.email=email
        self.gender = gender
        self.picture = picture
    }
    
    init(userID:AnyObject, userIDFB:AnyObject, userIDG:AnyObject, nickName:AnyObject, email:AnyObject, gender:AnyObject, picture:AnyObject){
        self.userID = userID
        self.userIDFB = userIDFB
        self.userIDG = userIDG
        self.nickName = nickName
        self.email=email
        self.gender = gender
        self.picture = picture
    }
    
}