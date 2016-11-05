//
//  ArticleDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import SwiftyJSON

class ArticleDao {
    
    func getArticles(parameters: [String: Any]? = nil, success: @escaping (_ articles: [Article]) -> Void, fail: @escaping (_ error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(method: .GET, endPoint: .articles, parameters: parameters,
                                          
            success: { result in
                                            
                success(self.parseArticles(json: JSON(result)))
                                            
            }, failure: { failure in
                
                fail("Não foi possível carregar os articles.")
            }
        )
    }
    
    fileprivate func parseArticles(json: JSON) -> [Article] {
        
        var articles = [Article]()
        
        for (_, article) in json {
            
            let article = parseArticle(article)
            
            articles.append(article)
        }
        
        return articles
    }
    
    fileprivate func parseArticle(_ json: JSON) -> Article {
        
        let id = json["id"].intValue
        let description = json["description"].stringValue
        let thumbnail = json["thumbnail"].stringValue
        let title = json["title"].stringValue
        
        let article = Article(id: id, title: title, description: description, thumbnail: thumbnail)
        
        return article
    }
}
