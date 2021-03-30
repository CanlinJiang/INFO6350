//
//  ViewController.swift
//  Class4_example2
//
//  Created by little tree on 2/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var textOfField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func alertAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sample Alert", message: "BIBIBIBI", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: {(alerAction) in
            self.label.text = self.textOfField?.text
            print("OK pressed")
        })
        let cancel = UIAlertAction(title: "Canceled", style: .cancel, handler: {(alerAction) in
            print("Cencel pressed")
        })
        
        alert.addAction(OK)
        alert.addAction(cancel)
        
        alert.addTextField{(textField) in
            textField.placeholder = "Type Content"
            self.textOfField = textField
        }
        
        self.present(alert, animated: true, completion: nil) //!
    }
    
}

