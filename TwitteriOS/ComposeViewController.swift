//
//  ComposeViewController.swift
//  TwitteriOS
//
//  Created by Himank Yadav on 3/2/16.
//  Copyright © 2016 himankyadav. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var composeTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.delegate = self
        composeTextView.text = "Placeholder"
        composeTextView.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write here..."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        TwitterClient.sharedInstance.composeTweet({ (ans:Bool) -> () in
            if(ans){
                self.navigationController?.popViewControllerAnimated(true)
            }
            }, failure: { (error:NSError) -> () in
                print(error.localizedDescription)
            }, content: composeTextView.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
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
