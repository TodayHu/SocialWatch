//
//  ViewController.swift
//  SocialWatch
//
//  Created by Francisco Caro Diaz on 09/03/15.
//  Copyright (c) 2015 AreQua. All rights reserved.
//

import UIKit
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion

class ViewController: UIViewController, FBLoginViewDelegate, GPPSignInDelegate {
    
    @IBOutlet weak var userTextView: UILabel!
    @IBOutlet var fbLoginView : FBLoginView!
    var signIn:GPPSignIn?
    var fileCoordinator = NSFileCoordinator()
    var friendList = [User]()
    
    @IBOutlet weak var gLoginView: GPPSignInButton!
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TYPE_REGISTER_RRSS = USER_FACEBOOK
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        gLoginView.hidden = true
        defaults.setObject(TYPE_REGISTER_RRSS, forKey: kLOGIN)
        defaults.synchronize()
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        let userImageURL = "https://graph.facebook.com/\(user.objectID)/picture?type=small";
        var userGender = user.objectForKey("gender") as String
        
        var userData = User(userID: user.objectID, nickName: user.name, email: userEmail, gender:userGender,picture:userImageURL);
        USER_DATA = userData
        
        userTextView.hidden = false
        userTextView.text = user.name
        
        var friendsRequest : FBRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict = result as NSDictionary
            println("Result Dict: \(resultdict)")
            var data : NSArray = resultdict.objectForKey("data") as NSArray
            
            for i in 0..<data.count {
                let valueDict : NSDictionary = data[i] as NSDictionary
                let id = valueDict.objectForKey("id") as String
                println("the id value is \(id)")
                let name = valueDict.objectForKey("name") as String
                println("the name value is \(name)")
                let first_name = valueDict.objectForKey("first_name") as String
                println("the first_name value is \(first_name)")
                let last_name = valueDict.objectForKey("last_name") as String
                println("the last_name value is \(last_name)")
            }
            
            var friends = resultdict.objectForKey("data") as NSArray
            println("Found \(friends.count) friends")
            self.saveFriendsList(friends)
        }
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
        gLoginView.hidden = false
        userTextView.hidden = true
        defaults.setObject(0, forKey: kLOGIN)
        defaults.synchronize()
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
        userTextView.hidden = true
    }
    
    private func saveFriendsList(friendsList :NSArray) {
        
        if let presentedItemURL = presentedItemURL {
            
            fileCoordinator.coordinateWritingItemAtURL(presentedItemURL, options: nil, error: nil)
                { [unowned self] (newURL) -> Void in
                    let dataToSave = NSKeyedArchiver.archivedDataWithRootObject(friendsList)
                    let success = dataToSave.writeToURL(newURL, atomically: true)
            }
        }
    }
    
    
    // MARK: Google+ Delegate methods
    
    @IBAction func loginGooglePlusButton(sender: AnyObject) {
        
        if TYPE_REGISTER_RRSS == USER_GOOGLE{
            signIn?.signOut()
            signIn?.disconnect()
            TYPE_REGISTER_RRSS = USER_DEFAULT
        }else{
            TYPE_REGISTER_RRSS = USER_GOOGLE
            
            //googleHelper.signIn?.delegate = self
            //googleHelper.login();
        
            signIn = GPPSignIn.sharedInstance()
            signIn?.shouldFetchGooglePlusUser = true
            signIn?.shouldFetchGoogleUserID = true
            signIn?.shouldFetchGoogleUserEmail = true
            signIn?.clientID = GOOGLE_CLIENT_ID
            signIn?.scopes = [kGTLAuthScopePlusLogin]
            signIn?.delegate = self
            signIn?.authenticate()
            gLoginView.setTitle("Log out", forState: UIControlState.Selected)
        }
        
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        
        if let gotError = error {
            fbLoginView.hidden = false
            
            let _title = "Atención"
            var _message = "No se ha podido iniciar sesion con Google"
            let alertController = Util.showMessage(_title,message: _message)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            fbLoginView.hidden = true
            
            let parameters = auth.parameters
            let id_token = parameters.objectForKey("id_token") as? String
            let access_token = parameters.objectForKey("access_token") as? String
            
            println("User: \(auth.userData)")
            println("User ID: \(auth.clientID)")
            var userNickName = signIn?.googlePlusUser.displayName
            println("User Name: \(userNickName)")
            var userEmail = auth.userEmail
            println("User Email: \(userEmail)")
            let userImageURL = signIn?.googlePlusUser.image.url as String!
            var userGender = signIn?.googlePlusUser.gender as String!
            
            var userData = User(userID: auth.clientID, nickName: userNickName!, email: userEmail, gender:userGender,picture:userImageURL);
            USER_DATA = userData
            
            userTextView.hidden = false
            userTextView.text = userNickName
            
        }
    }
    
    func didDisconnectWithError(error: NSError!) {
        fbLoginView.hidden = false
        /*
        userTextView.text = ""
        let _title = "Atención"
        var _message = "No se ha podido iniciar sesion con Google+"
        let alertController = Util.showMessage(_title,message: _message)
        self.presentViewController(alertController, animated: true, completion: nil)
        */
    }

}

// MARK: NSFilePresenter Protocol

extension ViewController: NSFilePresenter {
    
    var presentedItemURL: NSURL? {
        
        let groupURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(
            "group.arequa.socialwatch")
        
        let fileURL = groupURL?.URLByAppendingPathComponent("friendsList.bin")
        return fileURL
    }
    
    var presentedItemOperationQueue: NSOperationQueue {
        return NSOperationQueue.mainQueue()
    }
    
}
