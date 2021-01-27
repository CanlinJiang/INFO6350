//
//  ViewController.swift
//  Class1
//
//  Created by little tree on 1/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var labelIsPressed: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func Press(_ sender: Any) {
        if (labelIsPressed == true) {
            label.text = "Jiang"
            labelIsPressed = false;
        } else {
            label.text = "Canlin"
        }
        
    }
}

