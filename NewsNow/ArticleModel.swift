//
//  ArticleModel.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

struct Article {
    
    var id = Int()
    var title = String()
    var description = String()
    var thumbnail = String()
    
    init () {}
    
    init(id: Int, title: String, description: String, thumbnail: String) {
        
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
    }
}