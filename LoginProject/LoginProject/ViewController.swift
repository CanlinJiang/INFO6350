//
//  ViewController.swift
//  LoginProject
//
//  Created by little tree on 3/24/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginFunction(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)//各种类型https://stackoverflow.com/questions/25966215/whats-the-difference-between-all-the-selection-segues
//        let email = txtEmail.text!
//        let password = txtPassword.text!
//
//        if email.isValidEmail == false {
//            lblStatus.text = "Please enter valid email"
//        }
//
//
//        if email.count == 0 || password.count < 6 {
//            lblStatus.text = "Please enter valid email and password"
//        }
//
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                self.lblStatus.text = error?.localizedDescription
//                return;
//            }
//
//            self.performSegue(withIdentifier: "loginSegue", sender: self)
//        }
//    }
    }
    
}

