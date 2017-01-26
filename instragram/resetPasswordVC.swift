//
//  resetPasswordVC.swift
//  instragram
//
//  Created by bingkunyang on 1/21/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit
import Parse

class resetPasswordVC: UIViewController {
    
    // text fields
    @IBOutlet weak var emailTxt: UITextField!
    
    // buttons
    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    // click reset button
    @IBAction func resetBtn_click(_ sender: Any) {
        
        // hide keyboard
        self.view.endEditing(true)
        
        
        // email text field is empty
        if emailTxt.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Email field", message: "is empty", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        // request for reseting password
        PFUser.requestPasswordResetForEmail(inBackground: emailTxt.text!) { (success: Bool, error: Error?) in
            
            if success {
                
                // show alert message
                let alert = UIAlertController(title: "Email for reseting password", message: "has been sent to texted email", preferredStyle: UIAlertControllerStyle.alert)
                
                // if pressed ok, call dismiss func
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                
                print(error!.localizedDescription)
                
            }
            
        }
        
    }
    
    // click cancel button
    @IBAction func cancelBtn_click(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

   
}





