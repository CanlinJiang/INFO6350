//
//  SignOutViewController.swift
//  NewsApp
//
//  Created by little tree on 4/29/21.
//

import UIKit
import FirebaseAuth

class SignOutViewController: UIViewController {
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            popAlert(title: "Thank you", message: "You've been successfully signed out")
            
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    func popAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okTapped = UIAlertAction(title: "OK", style: .default) { okTapped in
            guard let loginViewController = self.storyboard?.instantiateViewController(identifier: loginVCID) else {return}
            
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
            
            
            
        }
        
        alert.addAction(okTapped)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}
