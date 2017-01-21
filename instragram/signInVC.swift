//
//  signInVC.swift
//  instragram
//
//  Created by bingkunyang on 1/21/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit

class signInVC: UIViewController {
    
    // text field
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    // buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // clicked sign in button
    @IBAction func signInBtn_click(_ sender: Any) {
        print("sign in pressed")
    }

    
    
}







