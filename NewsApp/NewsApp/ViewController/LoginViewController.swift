//
//  LoginViewController.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let authenticationUI = FUIAuth.defaultAuthUI();
        
        authenticationUI?.delegate = self
        authenticationUI?.providers = [FUIEmailAuth(), FUIFacebookAuth(), FUIGoogleAuth()]
        
        guard let authenticationViewController = authenticationUI?.authViewController() else { return }
        present(authenticationViewController, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let tabBarViewController = self.storyboard?.instantiateViewController(identifier: tabBarID) else {return}
        self.view.window?.rootViewController = tabBarViewController
        self.view.window?.makeKeyAndVisible()
        }
    }

