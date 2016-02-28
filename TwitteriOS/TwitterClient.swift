//
//  TwitterClient.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 2/15/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


var twitterConsumerKey = "E01Iglk5lwiLnE3rFO03eCh9g"
var twitterConsumerSecret = "ojzNJaK7C1GBP6giCvhMdh7cRcMJrtYwVRoyesEM2acNE3FdeU"
var twitterBaseURL = NSURL (string: "https://api.twitter.com")

var loginSuccess: (() -> ())?
var loginFailure: ((NSError) -> ())?

class TwitterClient: BDBOAuth1SessionManager {
    
    func login(success: () -> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemohimank://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Success in getting token")
            
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            
            
            }) { (error: NSError!) -> Void in
                print("Failure - Request Token")
                loginFailure?(error)
        }

        
    }
    
    func handleOpenUrl(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    loginFailure?(error)
            })
//            print("Pass - access token")
            
            
//            requestSerializer.saveAccessToken(accessToken)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                loginFailure?(error)
        }
        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                print("error: \(error.localizedDescription)")
        }
    }

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    func homeTimeLine(success: ([Tweet])->(), failure: (NSError) -> () ){
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("user: \(response)")
            
            let userDictionary = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(userDictionary)
            success(tweets)
            
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print (error)
        })
        
    }
}
