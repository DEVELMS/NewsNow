//
//  Video.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

struct Video {
    
    var id = String()
    var url = String()
    var description = String()
    var thumbnail = String()
    var duration = String()
    var related = [Video]()
    
    init () {}
    
    init(id: String, url: String, description: String, thumbnail: String, duration: String) {
        
        self.id = id
        self.url = url
        self.description = description
        self.thumbnail = thumbnail
        self.duration = duration
    }
}
