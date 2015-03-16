//
//  Event.swift
//  BitWatch
//
//  Created by Francisco Caro Diaz on 04/02/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation

class Friend {
    
    var friendTitle:String
    var friendSubtitle:String
    var friendImageName:String
    
    init(dataDictionary:NSDictionary) {
        friendTitle = dataDictionary.objectForKey("first_name") as String
        friendSubtitle = dataDictionary.objectForKey("last_name") as String
        let userFBID = dataDictionary.objectForKey("id") as String
        friendImageName = "https://graph.facebook.com/\(userFBID)/picture?type=small";
        
        println("the friendTitle value is \(friendTitle)")
        println("the friendSubtitle value is \(friendSubtitle)")
        println("the friendImageName value is \(friendImageName)")
    }
    
    class func newFriend(dataDictionary:Dictionary<String,String>) -> Friend {
        return Friend(dataDictionary: dataDictionary)
    }
    
    class func friendList(entryFriendList: NSArray) -> [Friend] {
        var array = [Friend]()
        for i in 0..<entryFriendList.count {
            let e : NSDictionary = entryFriendList[i] as NSDictionary
            let friend = Friend(dataDictionary: e)
            array.append(friend)
        }
        return array
    }
    
}
