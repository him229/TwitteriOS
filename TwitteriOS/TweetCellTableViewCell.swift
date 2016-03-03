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
    
    @IBAction func onFavorite(sender: AnyObject) {
        
    }
    @IBAction func onRetweet(sender: AnyObject) {
    }
    
    var tweet : Tweet! {
        didSet{
            tweetContent.text = tweet.text as! String
            let timeinterval = NSDate().timeIntervalSinceDate(tweet.timestamp!)
            print(timeinterval)
//            timestamp.text = tweet.timestamp as! String
            userImage.setImageWithURL(tweet.profileImgURL!)
            name.text = tweet.screenName as! String
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
