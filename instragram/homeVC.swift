//
//  homeVC.swift
//  instragram
//
//  Created by bingkunyang on 1/27/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit
import Parse


class homeVC: UICollectionViewController {
    
    // refresher variable
    var refresher : UIRefreshControl!
    
    // size pf page
    var page: Int = 10
    
    var uuidArray = [String]()
    var picArray = [PFFile]()
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color
        collectionView?.backgroundColor = .white
        
        // title at the top
        self.navigationItem.title = PFUser.current()!.username?.uppercased()
        
        // pull the refresh
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(homeVC.refresh), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refresher)
        
        // load posts func
        loadPosts()
        
    }
    
    
    
    // refresh function
    func refresh(){
        
        // reload datas info
        collectionView?.reloadData()
        
        // stop animating of refresher
        refresher.endRefreshing()
    }
    
    
    // load post func
    func loadPosts(){
        let query = PFQuery(className: "posts")
        query.whereKey("username", equalTo: PFUser.current()!.username as Any)
        query.limit = page
        query.findObjectsInBackground (block: { (objects, error) -> Void in
            if error == nil {
                
                // clean up
                self.uuidArray.removeAll(keepingCapacity: false)
                self.picArray.removeAll(keepingCapacity: false)
                
                
                // find related tpo our request
                for object in objects! {
                    
                    // add found data to arrays (holders)
                    self.uuidArray.append(object.value(forKey: "uuid") as! String)
                    self.picArray.append(object.value(forKey: "pic") as! PFFile)
                }
                
                self.collectionView?.reloadData()
                
            }
            else {
                print(error!.localizedDescription)
            }
        })
        
    }
    
    



    // cell number
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count * 20
    }
    
    
    // cell configuration
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // define cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! pictureCell
        
        // get picture from picArray
        picArray[0].getDataInBackground { (data, error) -> Void in
            if error == nil {
                cell.picImg.image = UIImage(data: data!)
            }
            else {
                print(error!.localizedDescription)
            }
        }
        
        return cell
        
    }
    
    
    // header config
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        //define header
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! headerView
        
        
        // get users data with connections to columns of PFUser class
        header.fullNameLbl.text = (PFUser.current()!.object(forKey: "fullname") as? String)?.uppercased()
        header.webTxt.text = PFUser.current()?.object(forKey: "web") as? String
        header.webTxt.sizeToFit()
        header.bioLbl.text = PFUser.current()?.object(forKey: "bio") as? String
        header.bioLbl.sizeToFit()
        
        let avaQuery = PFUser.current()?.object(forKey: "ava") as! PFFile
        avaQuery.getDataInBackground { (data: Data?, error: Error?) in
            header.avaImg.image = UIImage(data: data!)
        }
        
        header.button.setTitle("edit profile", for: UIControlState.normal)
        
        // STEP 2. Count statistics
        // count total posts
        let posts = PFQuery(className: "posts")
        posts.whereKey("username", equalTo: PFUser.current()!.username!)
        posts.countObjectsInBackground (block: { (count, error) -> Void in
            if error == nil {
                header.posts.text = "\(count)"
            }
        })
        
        // count total followings
        let followers = PFQuery(className: "follow")
        followers.whereKey("following", equalTo: PFUser.current()!.username!)
        followers.countObjectsInBackground (block: { (count, error) -> Void in
            if error == nil {
                header.followers.text = "\(count)"
            }
        })
        
        // count total followers
        let followings = PFQuery(className: "follow")
        followings.whereKey("follower", equalTo: PFUser.current()!.username!)
        followings.countObjectsInBackground (block: { (count, error) -> Void in
            if error == nil {
                header.followings.text = "\(count)"
            }
        })
        
        return header
        
    }

    
    /*
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    */

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
