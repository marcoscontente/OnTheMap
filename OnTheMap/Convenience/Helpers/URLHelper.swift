//
//  URLHelper.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 30/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class URLHelper {
    
    static func escapedParameters(_ parameters: [String:Any]) -> String {
        if parameters.isEmpty {
            return ""
        } else {
            var keyValuePairs = [String]()
            for (key, value) in parameters {
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            return "?\(keyValuePairs.joined(separator: "&"))"
        }
    }
    
    static func urlStringWithQueryParameters(_ scheme: String = "https", host: String!, path: String = "", queryPrameters: [String: String]) -> String {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in queryPrameters {
            components.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        return components.url!.absoluteString
    }
}
