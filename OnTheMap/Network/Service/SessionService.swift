//
//  SessionService.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 31/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class SessionService {
        
    func performUdacityLogin(_ username: String, password: String, completion: @escaping (_ success:Bool, _ errorMessage:String? ) -> Void) {
        var request = URLRequest(url: Service().getPathURL(path: Constants.sessionPath))
        request.httpMethod = Constants.HTTPMethodPost
        request = Service().setDefaultHeaders(request: request as! NSMutableURLRequest) as URLRequest
        
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
  
        
        Service().serviceRequest(request: request) { (result, error) in
            guard (error == nil) else {
                completion(false, error?.localizedDescription)
                return
            }
            guard let account = result?.value(forKey: Constants.account) as? NSDictionary else {
                completion(false, ErrorMessage.invalidEmailOrPassword.rawValue)
                return
            }
            
            guard let registered = account.value(forKey: Constants.registered) as? Bool else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let accountKey = account.value(forKey: Constants.key) as? String else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let session = result?.value(forKey: Constants.session) as? NSDictionary else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let sessionID = session.value(forKey: Constants.id) as? String else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            if (registered) {
                SharedSession.shared.accountKey = accountKey
                SharedSession.shared.sessionID = sessionID
                completion(true,nil)
            } else {
                completion(false,ErrorMessage.invalidUdacityLogin.rawValue)
            }
        }
    }
    
    func getUser(with userID: String, completion: @escaping (_ success: Bool?, _ failure: String?) -> Void) {
        
        var request = URLRequest(url: Service().getPathURL(path: Constants.userPath, pathExtension: "/" + userID))
        
        request.httpMethod = Constants.HTTPMethodGet
        request = Service().setDefaultHeaders(request: request as! NSMutableURLRequest) as URLRequest
        
        Service().serviceRequest(request: request) { (response, error) in
            guard (error == nil) else {
                completion(false, error?.localizedDescription)
                return
            }
      
            guard let userResponse = response as? [String:AnyObject] else {
                completion(false, error?.localizedDescription)
                return
            }
            
            let user = User.init(userResponse)
            SharedSession.shared.userSession = user
            completion(true,nil)
        }
    }
    
    func performFacebookLogin(_ fbToken: String, completion: @escaping (_ success:Bool, _ errorMessage:String? ) -> Void) {
        var request = URLRequest(url: Service().getPathURL(path: Constants.sessionPath))
        request.httpMethod = Constants.HTTPMethodPost
        request = Service().setDefaultHeaders(request: request as! NSMutableURLRequest) as URLRequest
        
        request.httpBody = "{\"facebook_mobile\": {\"access_token\": \"\(fbToken)\"}}".data(using: String.Encoding.utf8)
        
        Service().serviceRequest(request: request) { (result, error) in
            guard (error == nil) else {
                completion(false, error?.localizedDescription)
                return
            }
            guard let account = result?.value(forKey: Constants.account) as? NSDictionary else {
                completion(false, ErrorMessage.invalidEmailOrPassword.rawValue)
                return
            }
            
            guard let registered = account.value(forKey: Constants.registered) as? Bool else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let accountKey = account.value(forKey: Constants.key) as? String else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let session = result?.value(forKey: Constants.session) as? NSDictionary else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            guard let sessionID = session.value(forKey: Constants.id) as? String else {
                completion(false, ErrorMessage.couldNotLoadUserData.rawValue)
                return
            }
            
            if (registered) {
                SharedSession.shared.accountKey = accountKey
                SharedSession.shared.sessionID = sessionID
                completion(true,nil)
            } else {
                completion(false,ErrorMessage.invalidFacebookLogin.rawValue)
            }
        }
    }
    
    func performLogout(completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        var request = URLRequest(url: Service().getPathURL(path: Constants.sessionPath))
        request.httpMethod = Constants.HTTPMethodDelete
        request = Service().setDefaultHeaders(request: request as! NSMutableURLRequest) as URLRequest
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == Constants.xsrfCookieName { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: Constants.xsrfCookieValue)
        }
        
        Service().serviceRequest(request: request) { (result, error) in
            guard (error == nil) else {
                print("There was an error with your request: \(error!)")
                completion(false, error?.localizedDescription)
                return
            }
            completion(true, nil)
        }
    }    
}
