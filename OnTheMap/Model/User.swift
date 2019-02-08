//
//  User.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 08/02/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

struct User {
    
    var firstName: String?
    var lastName: String?
    var key: String?
    
    init?(_ parseResult: [String:AnyObject]) {
        guard let FirstName = parseResult[Constants.firstName] as? String else { return nil }
        firstName = FirstName
        guard let LastName = parseResult[Constants.lastName] as? String else { return nil }
        lastName = LastName
        guard let Key = parseResult[Constants.key] as? String else { return nil }
        key = Key
    }
    
    static func createUser(from results: [[String:AnyObject]]) -> [User] {
        var users = [User]()
        for result in results {
            if let user = User(result) {
                users.append(user)
            }
        }
        return users
    }

}
