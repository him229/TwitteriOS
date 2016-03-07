//
//  ProfileViewController.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 3/7/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    
    var profileUser : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = profileUser.name as! String
        tweetLabel.text = String(profileUser.tweetCount)
        followersLabel.text = String(profileUser.followers)
        followingLabel.text = String(profileUser.friends)
        profileImageView.setImageWithURL(profileUser.profileUrl!)

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
