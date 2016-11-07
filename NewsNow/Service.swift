//
//  Service.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import Just

enum Result<T> {
    
    case success(result: T)
    case failure(error: Int, message: String)
}

class Service: Requesting, NewsNowURL {
    
    static let sharedInstance = Service()
    
    func APIRequest(method: HTTPMethod, endPoint: RequestType, filters: [(name: String, value: Any)]? = nil, parameters: [String: Any]? = nil, absoluteURL: Bool = false, success: @escaping (Any) -> Void, failure: @escaping (Int) -> Void) {
        
        var url = ""
        
        if !absoluteURL {
            
            if let filters = filters { url = getUrl(endPoint, filters: filters) }
            else { url = getUrl(endPoint) }
        }
        else { url = endPoint.rawValue }
        
        print("request to: \(url)")
        
        switch method {
        case .GET :
            
            getTo(url: url, success: {
                result in
                success(result)
            }, failure: {
                status in
                failure(status)
            })
            
        default: print("HTTPMethod not supported")
        }
    }
    
    func APIRequestImage(url: String, success: @escaping (Any) -> Void, failure: @escaping (Int) -> Void)  {
        
        Just.get(url) {
            r in
            
            if r.ok {
                
                guard let response = r.content else {
                    print("no response")
                    return
                }
                
                Do.now {
                    success(response)
                }
            }
            else {
                
                guard let code = r.statusCode else {
                    print("failure without statusCode")
                    return
                }
                
                Do.now {
                    failure(code)
                }
            }
        }
    }
    
    private func getTo(url: String, success: @escaping (Any) -> Void, failure: @escaping (Int) -> Void) {

        Just.get(url) {
            r in
            
            if r.ok {
                
                guard let response = r.json else {
                    print("no response")
                    return
                }
                
                Do.now {
                    success(response)
                }
            }
            else {
                
                guard let code = r.statusCode else {
                    print("failure without statusCode")
                    return
                }
                
                Do.now {
                    failure(code)
                }
            }
        }
    }
}
