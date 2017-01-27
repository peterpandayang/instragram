//
//  signInVC.swift
//  instragram
//
//  Created by bingkunyang on 1/21/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit
import Parse

class signInVC: UIViewController {
    
    // text field
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    // buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // alignment
        label.frame = CGRect(x: 10, y: 80, width: self.view.frame.size.width - 20, height: 50)
        usernameTxt.frame = CGRect(x: 10, y: label.frame.origin.y + 70, width: self.view.frame.size.width - 20 , height: 30)
        passwordTxt.frame = CGRect(x: 10, y: usernameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20 , height: 30)
        forgotBtn.frame = CGRect(x: 10, y: passwordTxt.frame.origin.y + 30, width: self.view.frame.size.width, height: 30)
        signInBtn.frame = CGRect(x: 20, y: forgotBtn.frame.origin.y + 40, width: self.view.frame.size.width / 4, height: 30)
        signUpBtn.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signInBtn.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        
        
        
    }
    
    // clicked sign in button
    @IBAction func signInBtn_click(_ sender: Any) {
        print("sign in pressed")
        
        // hide keyboard
        self.view.endEditing(true)
        
        // if textFields are empty
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Please", message: "fill in fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        // login func
        PFUser.logInWithUsername(inBackground: usernameTxt.text!, password: passwordTxt.text!) { (user: PFUser?, error: Error?) in
            if error == nil {
                
                // remember user or save in App Memory did the user login or not
                UserDefaults.standard.set(user!.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                // call login func from AppDelegate.swift class
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
            }
        }
        
    }

    
    
}







