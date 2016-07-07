//
//  ViewController.swift
//  FacebookLoginButton
//
//  Created by Yan Paing Hein on 7/7/16.
//  Copyright © 2016 YanPaingHein. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookLoginButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print("User logged in with facebook ...")
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out of facebook ...")
        try! FIRAuth.auth()?.signOut()
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    @IBAction func signInAction(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(email.text!, password: password.text!, completion: { (user, error) -> Void in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            print("user create with email ...")
        })
    }
    
}

