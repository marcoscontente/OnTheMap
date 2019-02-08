//
//  JSON.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 30/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class JSON {
    
    class func serialize(dictionary: [String:AnyObject]? = nil) -> Data? {
        var jsonData: Data! = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dictionary!, options: .prettyPrinted) as Data
        } catch let error {
            print(error)
            return nil
        }
        deserialize(data: jsonData) { (result, error) in }
        return jsonData
    }
    
    class func deserialize(data: Data, completion: (_ success: AnyObject?, _ error: Error?) -> Void ) {
        var parsedResponse: AnyObject! = nil
        do {
            parsedResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            completion(parsedResponse, nil)
        } catch let error {
            completion(nil, error)
        }
    }
}
