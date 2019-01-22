//
//  UdacityConstants.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 21/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        static let AuthorizationURL = "https://www.udacity.com/api/session"
    }
    
    // MARK: Parameter Keys
    struct UdacityParameterKeys {
        
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct UdacityAccountKeys {
        static let Account = "account"
        static let Registered = "registered"
        static let Key = "key"
    }
    
    struct SessionKeys {
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
    }
}
