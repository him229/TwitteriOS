//
//  User.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 2/19/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name:NSString?
    var screenname:NSString?
    var profileUrl: NSURL?
    var tagline:NSString?
    var followers: Int = 0
    var friends: Int = 0
    var tweetCount: Int = 0
    
    var dictionary: NSDictionary?
    
    init(dictionary:NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        followers = dictionary["followers_count"] as! Int
        friends = dictionary["friends_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
    }
    
    static var _currentUser: User?
    class var currentUser:User? {
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
            
            if let userData = userData {
                
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                
                _currentUser = User(dictionary: dictionary)
                }
            return _currentUser
            }
        
            set(user) {
                
                _currentUser = user
                
                let defaults = NSUserDefaults.standardUserDefaults()
                if let user = user {
                    let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                    defaults.setObject(data, forKey: "currentUserData")
                    print("Reached her - saved data")
                } else{
                    defaults.setObject(nil, forKey: "currentUserData")
                }
                
                defaults.synchronize()
            }
        }
}
