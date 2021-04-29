//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import UIKit


class FavoriteViewController: UIViewController {
    
    let model = NewsModel()
    var newsList = [News]()

    @IBOutlet weak var newsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        model.delegate = self
        
        model.getNewsFromDB()
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = newsTableView.indexPathForSelectedRow else {return}
        
        let news = newsList[indexPath.row]
        let newsDetailViewController = segue.destination as! NewsDetailViewController
        newsDetailViewController.news = news
        
        newsTableView.deselectRow(at: newsTableView.indexPathForSelectedRow!, animated: false)
    }
}

extension FavoriteViewController: NewsModelProtocol {
    func newsRetrieved(_ newsList: [News]) {
        self.newsList = newsList;
        newsTableView.reloadData()
        }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! NewsTableViewCell
        cell.disPlayNews(newsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: goToNewsDetaileSegueFav, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
            let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
                var news = self.newsList[indexPath.row]
                self.model.deleteNewsFromDB(news)

        }
            delete.backgroundColor = UIColor.systemGreen

            return [delete]
        }
}


