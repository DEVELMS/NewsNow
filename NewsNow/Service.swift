//
//  Service.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import Alamofire

enum Result<T> {
    
    case success(result: T)
    case failure(error: Int, message: String)
}

class Service: NSObject, APIProtocol, NewsNowURL {
    
    static let sharedInstance = Service()
    private override init() {}
    
    func APIRequest(method: Alamofire.Method, endPoint: RequestType, filters: [(name: String, value: AnyObject)]? = nil, parameters: [String: AnyObject]? = nil, absoluteURL: Bool = false, success: AnyObject -> Void, failure: Int -> Void) {
        
        var url = ""
        
        if !absoluteURL {
            
            if let filters = filters { url = getUrl(endPoint, filters: filters) }
            else { url = getUrl(endPoint) }
        }
        else { url = endPoint.rawValue }
        
        print(url)
        
        Alamofire.request(method, url, parameters: parameters)
            .validate()
            .responseJSON {
                response in
                
                switch response.result {
                    
                case .Success(let data):
                    
                    success(data)
                    
                case .Failure(let error):
                    
                    var status = error.code
                    
                    if let statusCode = error.userInfo["StatusCode"] as? Int {
                        
                        status = statusCode
                    }
                    
                    failure(status)
                }
        }
    }
}
