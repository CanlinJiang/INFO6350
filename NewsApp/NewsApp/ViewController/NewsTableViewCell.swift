//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by little tree on 4/29/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var model = NewsModel()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    
    
    func disPlayNews(_ news: News) {
        titleLabel.text = news.title
        
        guard let imageUrl = news.urlToImage else {return}
        model.getImage(imageUrl) { image in
            
            self.newsImage.image = image
        }
    }
}
