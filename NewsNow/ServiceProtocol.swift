//
//  Protocols.swift
//  Foodsage
//
//  Created by Calebe Emerick on 23/05/16.
//  Copyright © 2016 EstrategiaMKTDigital. All rights reserved.
//

import Just

protocol Requesting {
    
    func APIRequest(method: HTTPMethod, endPoint: RequestType, filters: [(name: String, value: Any)]?, parameters: [String: Any]?, absoluteURL: Bool, success: @escaping (Any) -> Void, failure: @escaping (Int) -> Void)
}
