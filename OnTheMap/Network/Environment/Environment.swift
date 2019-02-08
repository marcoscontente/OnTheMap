//
//  Environment.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 31/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class Environment {
    
    static let shared = Environment()
    
    var udacityBaseUrl: String!
    var parseBaseUrl: String!
    var parseApplicationId: String!
    var parseApiKey: String!
    var facebookApiId: String!

    init() {
        environmentSetup()
    }
    
    func environmentSetup() {
        self.udacityBaseUrl = Constants.udacityURL
        self.parseBaseUrl = Constants.parseURL
        self.parseApplicationId = Constants.parseAppIdValue
        self.parseApiKey = Constants.parseApiKeyValue
        self.facebookApiId = Constants.facebookApiIdValue
    }
}
