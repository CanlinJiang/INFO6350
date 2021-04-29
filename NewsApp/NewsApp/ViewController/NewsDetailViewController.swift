//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by little tree on 4/29/21.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController, WKNavigationDelegate {
    
    var news: News?
    var model = NewsModel()
    @IBOutlet weak var newsWebView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsWebView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = news?.url {
            guard let url = URL(string: url) else {return}
            let webRequest = URLRequest(url: url)
            
            spinner.startAnimating()
            spinner.alpha = 1
            newsWebView.load(webRequest)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
    
}


