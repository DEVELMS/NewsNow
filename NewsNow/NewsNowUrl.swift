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
    
    func getUrl(type: RequestType, filters: [(name: String, value: AnyObject)]? = nil) -> String {
        
        let url = type.rawValue
        
        guard let filters = filters else {
            
            return url
        }
        
        return getUrlWithFilters(url, filters: filters)
    }
    
    private func getUrlWithFilters(url: String, filters: [(name: String, value: AnyObject)]) -> String {

        var newUrl = url
        
        for filter in filters.enumerate() {
            
            var separator = "?"
            
            if filter.index > 0 {
                
                separator = "&"
            }
            
            newUrl = "\(newUrl)\(separator)\(filter.element.name)=\(filter.element.value)"
        }
        
        return newUrl
    }
}

enum RequestType: String {
    
    case video = "http://private-6cb7c-lmsdev.apiary-mock.com/video"
    case videos = "http://private-6cb7c-lmsdev.apiary-mock.com/videos"
    case related = "http://private-6cb7c-lmsdev.apiary-mock.com/related"
}
