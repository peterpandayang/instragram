//
//  signUpVC.swift
//  instragram
//
//  Created by bingkunyang on 1/21/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {
    
    // profile image
    @IBOutlet weak var avaImg: UIImageView!
    
    // textFields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    
    @IBOutlet weak var signUpBtn: UIScrollView!
    @IBOutlet weak var cancelBtn: UIScrollView!
    
    
    // scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // reset default size
    var scrollViewHeight: CGFloat = 0
    
    // keyBoard frame size
    var keyboard = CGRect()
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scrollview frame size
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height
        
        // check notificatons if keyboard is shown or not
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)

        // declare hide keyboard tap
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
    }
    
    
    // hide keyboard if tapped
    func hideKeyboardTap(recogonizer: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // show keyboard function
    func showKeyboard(notification: Notification){
        
        // define keyboard size
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        
        // move up UI
        UIView.animate(withDuration: 0.4) {
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        }
        
    }
    
    // hide keyboard function
    func hideKeyboard(notification: Notification){
        
        // move up UI
        self.scrollView.frame.size.height = self.view.frame.height
        
    }
    
    // click sign up
    @IBAction func signUpBtn_click(_ sender: Any) {
        print("singup pressed")
    }
    
    // click cancel
    @IBAction func cancelBtn_click(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}





