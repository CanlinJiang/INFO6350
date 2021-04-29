//
//  News.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import Foundation
import UIKit


struct articles: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
