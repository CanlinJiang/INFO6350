//
//  AddNewContentViewController.swift
//  NewsApp
//
//  Created by little tree on 4/29/21.
//

import UIKit

class AddNewContentViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    var model = NewsModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        var news = News()
        news.title = titleTextField.text
        news.url = urlTextField.text
        news.urlToImage = imageUrlTextField.text
        news.newsId = UUID().uuidString
        model.saveNewsToDB(news)
    dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
