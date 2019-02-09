//
//  Service.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 04/02/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class Service {
    
    func getPathURL(udacity: Bool = true, path: String = "", pathExtension: String = "", parameters: String = "") -> URL {
        if !udacity {
            return URL(string: Environment.shared.parseBaseUrl + path + pathExtension + parameters)!
        }
        return URL(string: Environment.shared.udacityBaseUrl + path + pathExtension + parameters)!
    }
    
    func setDefaultHeaders(udacity: Bool = true, request: NSMutableURLRequest) -> NSMutableURLRequest {
        
        if udacity {
            request.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.contentType)
            request.addValue(Constants.applicationJson, forHTTPHeaderField: Constants.accept)
        } else {
            request.addValue(Constants.parseAppIdValue, forHTTPHeaderField: Constants.parseApplicationID)
            request.addValue(Constants.parseApiKeyValue, forHTTPHeaderField: Constants.parseApiKey)
        }
        
        return request
    }

    func serviceRequest(shouldNormalizeData: Bool = true,
                        request: URLRequest,
                        completion: @escaping(_ success: AnyObject?, _ failure: Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard (error == nil) else {
                let userInfo: [String : Any] = [NSLocalizedDescriptionKey: "No internet connection"]
                completion(nil,NSError(domain: "Error", code: 500, userInfo: userInfo))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode >= 200 && statusCode <= 299 else {
                    let httpError = (response as? HTTPURLResponse)?.statusCode
                    let errorString = HTTPURLResponse.localizedString(forStatusCode: httpError!)
                    if httpError == 403 {
                        let userInfo: [String : Any] = [NSLocalizedDescriptionKey: ErrorMessage.invalidEmailOrPassword.rawValue]
                        completion(nil,NSError(domain: "Error", code: 403, userInfo: userInfo))
                    } else {
                        let userInfo: [String : Any] = [NSLocalizedDescriptionKey: errorString]
                        completion(nil,NSError(domain: "Error", code: httpError!, userInfo: userInfo))
                    }
                    return
            }
            
            guard let data = data else {
                print(ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            if shouldNormalizeData {
                JSON.deserialize(data: self.normalizeUdacityData(data)!, completion: completion)
                print(String(data: data, encoding: .utf8)!)
            } else {
                JSON.deserialize(data: data, completion: completion)
                print(String(data: data, encoding: .utf8)!)
            }
            
        }
        task.resume()
    }
    
    private func normalizeUdacityData(_ data: Data?) -> Data? {
        guard let data = data, !data.isEmpty else { return nil }
        let range = Range(5..<data.count)
        let normalizedData = data.subdata(in: range) /* subset response data! */
        return normalizedData
    }

}
