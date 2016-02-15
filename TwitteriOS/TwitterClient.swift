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

class TwitterClient: BDBOAuth1SessionManager {

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
