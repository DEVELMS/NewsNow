//
//  Protocols.swift
//  Foodsage
//
//  Created by Calebe Emerick on 23/05/16.
//  Copyright © 2016 EstrategiaMKTDigital. All rights reserved.
//

import Alamofire

protocol APIProtocol: NSObjectProtocol {
    
    func APIRequest(method: Alamofire.Method, endPoint: RequestType, filters: [(name: String, value: AnyObject)]?, parameters: [String: AnyObject]?, absoluteURL: Bool, success: AnyObject -> Void, failure: Int -> Void)
}
