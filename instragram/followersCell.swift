//
//  followersCell.swift
//  instragram
//
//  Created by bingkunyang on 2/13/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit
import Parse

class followersCell: UITableViewCell {
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var followBtn: UIButton!

    // default func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2;
        avaImg.clipsToBounds = true
        
    }
    
    // clicked follow/ unfollow
    @IBAction func followBtn_click(_ sender: Any) {
        
        let title = followBtn.title(for: UIControlState())
        
        // to follow
        if title == "FOLLOW" {
            let object = PFObject(className: "follow")
            object["follower"] = PFUser.current()?.username
            object["following"] = usernameLbl.text
            object.saveInBackground(block: { (success, error) -> Void in
                if success {
                    self.followBtn.setTitle("FOLLOWING", for: UIControlState())
                    self.followBtn.backgroundColor = .green
                } else {
                    print(error?.localizedDescription as Any)
                }
            })
        }
            
        // unfollow
        else {
            let query = PFQuery(className: "follow")
            query.whereKey("follower", equalTo: PFUser.current()!.username!)
            query.whereKey("following", equalTo: usernameLbl.text!)
            query.findObjectsInBackground(block: { (objects, error) -> Void in
                if error == nil {
                    
                    for object in objects! {
                        object.deleteInBackground(block: { (success, error) -> Void in
                            if success {
                                self.followBtn.setTitle("FOLLOW", for: UIControlState())
                                self.followBtn.backgroundColor = .lightGray
                            } else {
                                print(error?.localizedDescription as Any)
                            }
                        })
                    }
                    
                } else {
                    print(error?.localizedDescription as Any)
                }
            })
        }
    }

}


