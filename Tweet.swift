//
//  Tweet.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 2/19/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text:NSString?
    var timestamp:NSDate?
    var retweetCount:Int = 0
    var favoritesCount:Int = 0
    var profileImgURL: NSURL?
    var screenName:NSString?
    var id:Int = 0
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        var profileImgURLString = dictionary["user"]!["profile_image_url_https"] as? String
        if profileImgURLString != nil{
            profileImgURL = NSURL(string: profileImgURLString!)
        }else{
            profileImgURL = nil
        }
        screenName = dictionary["user"]!["screen_name"] as? String
        id = (dictionary["id"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
