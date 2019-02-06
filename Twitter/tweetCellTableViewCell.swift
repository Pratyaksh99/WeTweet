//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Pratyaksh Motwani on 1/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavorite(_ isFavorited:Bool) {
        
        favorited = isFavorited
        
        if (favorited) {
            
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
            
        }
        else {
            
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        
        if (toBeFavorited) {
            
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                
                self.setFavorite(true)
                
            }, failure: { (Error) in
                
                print("Error Favoriting!!! \(Error)")
                
            })
            
        }
        else {
            
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                
                self.setFavorite(false)
                
            }, failure: { (Error) in
                
                print("Error Unfavoriting!!! \(Error)")
                
            })
            
        }
        
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        
        if (isRetweeted) {
            
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        }
        else {
            
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
        
    }
    
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            
            self.setRetweeted(true)
            
        }, failure: { (Error) in
            
            print("Error Retweeting!!! \(Error)")
            
        })
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
