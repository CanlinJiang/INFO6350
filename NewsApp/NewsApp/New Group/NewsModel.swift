    //
    //  NewsModel.swift
    //  NewsApp
    //
    //  Created by little tree on 4/28/21.
    //
    
    import Foundation
    import PromiseKit
    import SwiftyJSON
    import Firebase
    
    
    protocol NewsModelProtocol {
        
        func newsRetrieved(_ newsList: [News])
    }
    
    
    class NewsModel {
        var delegate: NewsModelProtocol?
        var listener: ListenerRegistration?
        
        func getNewsFromAPI(_ urlString: String) {
            guard let url = URL(string: urlString) else {return}
            let session = URLSession.shared
            let fetch = session.dataTask(with: url) { (rawData, response, error) in
                
                if (error != nil || rawData == nil) {
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let articlesHelper  = try decoder.decode(ArticlesHelper.self, from: rawData!)
                    let articleList = articlesHelper.articles!
                    var newsList = [News]()
                    for article in articleList {
                        var news = News(title: article.title, url: article.url, urlToImage: article.urlToImage)
                        newsList.append(news)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.delegate?.newsRetrieved(newsList)
                    }
                }
                catch {
                    
                }
            }
            fetch.resume()
        }
        
        func getImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else {return}
            let session = URLSession.shared
            let fetch = session.dataTask(with: url) { (rawData, response, error) in
                
                if (error != nil || rawData == nil) {
                    return
                }
                let image = UIImage(data: rawData!)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            fetch.resume()
        }
        
        
        
        deinit {
            listener?.remove()
        }
        func getNewsFromDB() {
            let db = Firestore.firestore()
            
            self.listener = db.collection(userId).addSnapshotListener() { snapshot, error in
                
                if error == nil && snapshot != nil {
                    var newsList = [News]()
                    
                    for doc in snapshot!.documents {
                        
                        let news = News(title: doc["title"] as! String, url: doc["url"] as! String, urlToImage: doc["urlToImage"] as! String, newsId: doc["newsId"] as! String)
                        
                        newsList.append(news)
                        DispatchQueue.main.async {
                            self.delegate?.newsRetrieved(newsList)
                        }
                        
                    }
                }
                
            }
        }
        
        func deleteNewsFromDB(_ news: News) {
            let db = Firestore.firestore()
            db.collection(userId).document(news.newsId!).delete()
        }
        
        func saveNewsToDB(_ news: News) {
            let db = Firestore.firestore()
            
            db.collection(userId).document(news.newsId!).setData(newsToDictionary(news), merge: true)
        }
        
        func newsToDictionary(_ news: News) -> [String:Any]  {
            var dictionary = [String: Any]()
            
            dictionary["title"] = news.title
            dictionary["url"] = news.url
            dictionary["urlToImage"] = news.urlToImage
            dictionary["newsId"] = news.newsId
            dictionary["saved"] = true
            
            return dictionary
        }
    }
    
    
    
    
    
    
    
    
