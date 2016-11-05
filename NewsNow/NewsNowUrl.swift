//
//  BaseUrl.swift
//  Foodsage
//
//  Created by Calebe Emerick on 30/06/16.
//  Copyright © 2016 EstrategiaMKTDigital. All rights reserved.
//

import Foundation

protocol NewsNowURL { }

extension NewsNowURL {
    
    func getUrl(_ type: RequestType, filters: [(name: String, value: Any)]? = nil) -> String {
        
        let url = type.rawValue
        
        guard let filters = filters else {
            
            return url
        }
        
        return getUrlWithFilters(url, filters: filters)
    }
    
    fileprivate func getUrlWithFilters(_ url: String, filters: [(name: String, value: Any)]) -> String {

        var newUrl = url
        
        for (index, filter) in filters.enumerated() {
            
            var separator = "?"
            
            if index > 0 {
                
                separator = "&"
            }
            
            newUrl = "\(newUrl)\(separator)\(filter.name)=\(filter.value)"
        }
        
        return newUrl
    }
}

enum RequestType: String {
    
    case video = "http://private-6cb7c-lmsdev.apiary-mock.com/video"
    case videos = "http://private-6cb7c-lmsdev.apiary-mock.com/videos"
    case related = "http://private-6cb7c-lmsdev.apiary-mock.com/related"
    case articles = "http://private-6cb7c-lmsdev.apiary-mock.com/articles"
}
