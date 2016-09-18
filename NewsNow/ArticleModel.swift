//
//  ArticleModel.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

struct Article {
    
    var id = Int()
    var description = String()
    var thumbnail = String()
    
    init () {}
    
    init(id: Int, description: String, thumbnail: String) {
        
        self.id = id
        self.description = description
        self.thumbnail = thumbnail
    }
}