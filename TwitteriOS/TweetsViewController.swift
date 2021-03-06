//
//  TweetsViewController.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 2/26/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    var userDictionary: [NSDictionary]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("user: \(response)")
            
           self.userDictionary = response as! [NSDictionary]
            
            self.tweets = Tweet.tweetsWithArray(self.userDictionary)
//            print("\(self.tweets[10].text)")
            
            self.tableView.reloadData()

            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print ("Error")
        })
        
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            //print("user: \(response)")
            
            self.userDictionary = response as! [NSDictionary]
            
            self.tweets = Tweet.tweetsWithArray(self.userDictionary)
            //            print("\(self.tweets[10].text)")
            
            self.tableView.reloadData()
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print ("Error")
        })
        refreshControl.endRefreshing()
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tweets != nil)
        {
            return tweets!.count
        }
        else {return 0}
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCellTableViewCell
        
//        cell.tweetContent.text = tweets[indexPath.row].text as! String
        cell.tweet = tweets[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        if segue.identifier == "profileSegue"{
        let vc = segue.destinationViewController as! ProfileViewController
            vc.profileUser = User.currentUser}
        
        if segue.identifier == "cellSegue"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tempDict = userDictionary![indexPath!.row]
            let newUser = User(dictionary: tempDict["user"] as! NSDictionary)
            let vc = segue.destinationViewController as! ProfileViewController
            vc.profileUser = newUser
        }
        
    }

}
