//
//  InterfaceController.swift
//  SocialWatch WatchKit Extension
//
//  Created by Francisco Caro Diaz on 10/03/15.
//  Copyright (c) 2015 AreQua. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var tableView: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        NSFileCoordinator.addFilePresenter(self)
        
        fetchTodoItems()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: Helper method
    
    private func setupTable() {
        
        var rowTypesList = [String]()
        
        for friend in _friendsData {
            
            var typeFound = false
            let friendImage = friend.friendImageName
            
            if strlen(friendImage) > 0 {
                rowTypesList.append("FriendWithImageRow")
                typeFound = true
            }
            
            if typeFound == false {
                rowTypesList.append("OrdinaryFriendRow")
            }
        }
        
        tableView.setRowTypes(rowTypesList)
        
        for var i = 0; i < tableView.numberOfRows; i++ {
            
            let row: AnyObject? = tableView.rowControllerAtIndex(i)
            let friend = _friendsData[i]
            
            if row is FriendWithImageRow {
                let importantRow = row as FriendWithImageRow
                let url = NSURL(string: friend.friendImageName);
                let picData = NSData(contentsOfURL: url!);
                let img = UIImage(data: picData!);
                
                importantRow.friendImage.setImage(img)
                importantRow.titleLabel.setText(friend.friendTitle)
                importantRow.subTitleLabel.setText(friend.friendSubtitle)
            } else {
                let ordinaryRow = row as OrdinaryFriendRow
                ordinaryRow.titleLabel.setText(friend.friendTitle)
                ordinaryRow.subtitleLabel.setText(friend.friendSubtitle)
            }
        }
        
    }
    
    // MARK: Populate Table From File Coordinator
    var friendsList :NSArray = []
    var _friendsData:[Friend] = []
    private func fetchTodoItems() {
        
        let fileCoordinator = NSFileCoordinator()
        
        if let presentedItemURL = presentedItemURL {
            
            fileCoordinator.coordinateReadingItemAtURL(presentedItemURL, options: nil, error: nil)
                { [unowned self] (newURL) -> Void in
                    
                    if let savedData = NSData(contentsOfURL: newURL) {
                        self.friendsList = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as [NSArray]
                        self._friendsData = Friend.friendList(self.friendsList)
                        self.setupTable()
                    }
            }
        }
    }

}

// MARK: NSFilePresenter Protocol

extension InterfaceController: NSFilePresenter {
    
    var presentedItemURL: NSURL? {
        
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(
            "group.arequa.socialwatch")
        
        let fileURL = groupURL?.URLByAppendingPathComponent("friendsList.bin")
        return fileURL
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
    
    func presentedItemDidChange() {
        fetchTodoItems()
    }
}
