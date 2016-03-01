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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
