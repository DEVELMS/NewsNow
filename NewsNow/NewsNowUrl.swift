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
        var idException = false
        
        for filter in filters.enumerate() {
            
            var separator = "?"
            
            if filter.index > 0 {
                
                separator = "&"
            }
            
            if filter.element.name == "[id]" || filter.element.name == "[page]" {
                
                newUrl = "\(newUrl)/\(filter.element.value)"
                
                idException = true
            }
            else {
            
                if idException {
                    
                    separator = "?"
                    idException = false
                }
                
                newUrl = "\(newUrl)\(separator)\(filter.element.name)=\(filter.element.value)"
            }
        }
        
        return newUrl
    }
}

enum RequestType: String {
    
    case videos = "http://private-6cb7c-lmsdev.apiary-mock.com/videos"
    case related = "http://private-6cb7c-lmsdev.apiary-mock.com/related"
}
