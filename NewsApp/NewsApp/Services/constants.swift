//
//  constants.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import Foundation
import FirebaseAuth

let loginVCID = "LogInViewController"
let tabBarID = "tabBarViewController"
let goToNewsDetailSegue = "goToNewsDetail"
let goToNewsDetaileSegueFavorite = "goToNewsDetailFromFavorite"
let goToAddNewSegue  = "goToAddNewSegue"
let newsCell = "NewsCell"
let favoriteCell = "FavoriteCell"
let url = "https://newsapi.org/v2/everything?q=apple&from=2021-04-28&to=2021-04-28&sortBy=popularity&apiKey=2c200f488e264b138c48bd28ab904b43"
let userId = Auth.auth().currentUser?.uid;
