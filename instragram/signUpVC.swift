//
//  signUpVC.swift
//  instragram
//
//  Created by bingkunyang on 1/21/17.
//  Copyright © 2017 Developers. All rights reserved.
//

import UIKit
import Parse


class signUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // profile image
    @IBOutlet weak var avaImg: UIImageView!
    
    // textFields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
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
        
        
        
        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
        avaImg.clipsToBounds = true
        
        // declare select image tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(loadImg))
        avaTap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)
        
        
        // alignment
        avaImg.frame = CGRect(x: self.view.frame.size.width / 2 - 40, y: 40, width: 80, height: 80)
        usernameTxt.frame = CGRect(x: 10, y: avaImg.frame.origin.y + 90, width: self.view.frame.size.width - 20, height: 30)
        passwordTxt.frame = CGRect(x: 10, y: usernameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        repeatPassword.frame = CGRect(x: 10, y: passwordTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        emailTxt.frame = CGRect(x: 10, y: repeatPassword.frame.origin.y + 60, width: self.view.frame.size.width - 20, height: 30)
        fullnameTxt.frame = CGRect(x: 10, y: emailTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        bioTxt.frame = CGRect(x: 10, y: fullnameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        webTxt.frame = CGRect(x: 10, y: bioTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        
        signUpBtn.frame = CGRect(x: 20, y: webTxt.frame.origin.y + 50, width: self.view.frame.size.width / 4, height: 30)
        cancelBtn.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signUpBtn.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        
        
        // background
        let bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        bg.image = UIImage(named: "wallpapers.jpg")
        bg.layer.zPosition = -1
        self.view.addSubview(bg)
        
    }
    
    
    // call picker to select image
    func loadImg(recognizer: UITapGestureRecognizer){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    // connect selected image to our ImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
        
        // move down UI
        self.scrollView.frame.size.height = self.view.frame.height
        
    }
    
    
    @IBAction func signUpBtn_click(_ sender: Any) {
        
        print("singup pressed")
        
        // dismiss keyboard
        self.view.endEditing(true)
        
        // if fields are empty
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPassword.text!.isEmpty || emailTxt.text!.isEmpty || bioTxt.text!.isEmpty || webTxt.text!.isEmpty) {
            
            // alert message
            let alert = UIAlertController(title: "PLEASE", message: "fill all fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        // if passwords are different
        if passwordTxt.text != repeatPassword.text {
            
            // alert message
            let alert = UIAlertController(title: "PASSWORDS", message: "do not match", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // send data to server to related columns
        let user = PFUser()
        user.username = usernameTxt.text?.lowercased()
        user.email = emailTxt.text?.lowercased()
        user.password = passwordTxt.text
        user["fullname"] = fullnameTxt.text?.lowercased()
        user["bio"] = bioTxt.text
        user["web"] = webTxt.text?.lowercased()
        
        // in edit profile it's gonna be assigned
        user["tel"] = ""
        user["gender"] = ""
        
        
        // convert our image for sending to the server
        let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        let avaFile = PFFile(name: "ava.jpg", data: avaData!)
        user["ava"] = avaFile
        
        
        // save data in server
        user.signUpInBackground { (success, error: Error?) in
            if success {
                print("registered")
                
                // remenber logged user
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                // call login func from Appdelegate.swift class
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
            }
            else {
                
                // show alert message
                let alert = UIAlertController(title: "Please", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)

            }
        }
        
    }
    
    
    
    // click cancel
    @IBAction func cancelBtn_click(_ sender: Any) {
        
        // hide keyboard when pressed cancel
        self.view.endEditing(true)
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    

}





