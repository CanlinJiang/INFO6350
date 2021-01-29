//
//  ViewController.swift
//  Slot Machine
//
//  Created by Ashisish on 1/27/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var labelWin: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var buttonPlay: UIButton!
    
    
    let imageArray = ["1", "2", "3", "4",  "5", "6"]
    
    var rand1 = Int.random(in: 0...5)
    var rand2 = Int.random(in: 0...5)
    
    var balance = 5
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImages()
        labelWin.text = "Please tap Play button"
        labelBalance.text = "Your balance = \(balance)$"
    }
    
    func changeImages() {
        rand1 = Int.random(in: 0...5)
        rand2 = Int.random(in: 0...5)
        image1.image = UIImage(named: imageArray[rand1])
        image2.image = UIImage(named: imageArray[rand2])
    }
    
    
    
    @IBAction func playSlotMachine(_ sender: UIButton) {
        changeImages()
        
        if (rand1 + rand2) == 5 {
            labelWin.text = "You won 3$"
            balance += 3;
        } else if (rand1 + rand2) > 5{
            labelWin.text = "You won 1$"
            balance += 1;
        } else {
            labelWin.text = "You lose 1$"
            balance -= 1;
        }
        
        labelBalance.text = "Your balance = \(balance)$"
        
        if balance <= 0 {
            buttonPlay.isEnabled = false
            labelWin.text = "Please restart app"
        }

    }
    

}

