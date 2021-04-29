//
//  NewsViewController.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import UIKit

class NewsViewController: UIViewController{
    var newsList: [News] = [News]()
    var model = NewsModel()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Random News";
        newsTableView.delegate = self
        newsTableView.dataSource = self
        model.delegate = self
        
        model.getNewsFromAPI(url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = newsTableView.indexPathForSelectedRow else {return}
        
        let news = newsList[indexPath.row]
        let newsDetailViewController = segue.destination as! NewsDetailViewController
        newsDetailViewController.news = news
        newsTableView.deselectRow(at: newsTableView.indexPathForSelectedRow!, animated: false)
    }
}


extension NewsViewController: NewsModelProtocol {
    func newsRetrieved(_ newsList: [News]) {
        self.newsList = newsList;
        newsTableView.reloadData()
    }
}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        cell.disPlayNews(newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: goToNewsDetailSegue, sender: self)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let save = UITableViewRowAction(style: .default, title: "Add To Favorite") { (action, indexPath) in
            var news = self.newsList[indexPath.row]
            if !news.saved {
                self.newsList[indexPath.row].saved = true;
                news.newsId = UUID().uuidString
                self.model.saveNewsToDB(news)
            }
        }
        save.backgroundColor = UIColor.systemOrange
        
        
        return [save]
    }
}


