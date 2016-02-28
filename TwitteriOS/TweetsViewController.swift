//
//  TweetsViewController.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 2/26/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("user: \(response)")
            
            let userDictionary = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(userDictionary)
            print("\(tweets[0].text)")
            //print("\(user.name)")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print ("Error")
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
