//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 14/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

struct StudentLocation {
    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Float
    var longitude: Float
    var createdAt: Date
    var updatedAt: Date
    var ACL: Data
}
