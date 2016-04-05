//
//  FBViewController.swift
//  iBaby
//
//  Created by Calamita, Lorenzo on 01/04/16.
//  Copyright © 2016 Calamita, Lorenzo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FBViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            
            print("already loggedin") // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("Ciao Ciao")
    }
 
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if FBSDKAccessToken.currentAccessToken() != nil {
            
            print(FBSDKAccessToken.currentAccessToken().tokenString)
        }

        if ((error) != nil) {
            print("error handling")
        } else if result.isCancelled {
            print("Cancelled")
        } else {
            print("result handling")
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                print("result handling - email read")
            }
        }
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
