//
//  TweetCellTableViewCell.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 3/1/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {


    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var favCountLabel: UILabel!
    
    var id:Int = 0
    
    @IBOutlet weak var retweetCountLabel: UILabel!

    
    @IBAction func onFavorite(sender: AnyObject) {
        id = tweet.id
        TwitterClient.sharedInstance.favIncrement({ (ans: Int) -> () in
            self.favCountLabel.text = String(ans)
            }, failure: { (error:NSError) -> () in
                print(error)
            }, id: id)
        
    }
    @IBAction func onRetweet(sender: AnyObject) {
        id = tweet.id
        TwitterClient.sharedInstance.retweetIncrement({ (ans: Int) -> () in
            self.retweetCountLabel.text = String(ans)
            }, failure: { (error:NSError) -> () in
                print(error)
            }, id: id)
    }
    
    var tweet : Tweet! {
        didSet{
            tweetContent.text = tweet.text as! String
            let timeinterval = Int(NSDate().timeIntervalSinceDate(tweet.timestamp!))
            var timeintervalString = ""
            if (timeinterval < 3600){
                timeintervalString = String(timeinterval/60) + "m"
            }else{
                timeintervalString = String(timeinterval/3600) + "h"
            }
            timestamp.text = (timeintervalString) as! String
            userImage.setImageWithURL(tweet.profileImgURL!)
            name.text = tweet.screenName as! String
            favCountLabel.text = String(tweet.favoritesCount)
            retweetCountLabel.text = String(tweet.retweetCount)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
