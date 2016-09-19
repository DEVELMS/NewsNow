//
//  ArticleDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import SwiftyJSON

class ArticleDao {
    
    func getArticles(parameters: [String: AnyObject]? = nil, success: (articles: [Article]) -> Void, fail: (error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(.GET, endPoint: .articles, parameters: parameters,
                                          
            success: { result in
                                            
                success(articles: self.parseArticles(JSON(result)))
                                            
            }, failure: { failure in
                
                fail(error: "Não foi possível carregar os articles.")
            }
        )
    }
    
    private func parseArticles(json: JSON) -> [Article] {
        
        var articles = [Article]()
        
        for (_, article) in json {
            
            let article = parseArticle(article)
            
            articles.append(article)
        }
        
        return articles
    }
    
    private func parseArticle(json: JSON) -> Article {
        
        let id = json["id"].intValue
        let description = json["description"].stringValue
        let thumbnail = json["thumbnail"].stringValue
        let title = json["title"].stringValue
        
        let article = Article(id: id, title: title, description: description, thumbnail: thumbnail)
        
        return article
    }
}
