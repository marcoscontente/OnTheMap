//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 14/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation
import MapKit

struct StudentInformation {
    
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectID: String?
    var uniqueKey: String?
    var updatedAt: String?
    var fullName: String? {
        return "\(firstName!) \(lastName!)"
    }

    init?(_ parseResult: [String:AnyObject]) {
        guard let CreatedAt = parseResult[Constants.createdAt] as? String else { return nil }
        createdAt = CreatedAt
        guard let ObjectID = parseResult[Constants.objectIDKey] as? String else { return nil }
        objectID = ObjectID
        guard let UniqueKey = parseResult[Constants.uniqueKeyKey] as? String else { return nil }
        uniqueKey = UniqueKey
        guard let FirstName = parseResult[Constants.firstNameKey] as? String else { return nil }
        firstName = FirstName
        guard let LastName = parseResult[Constants.lastNameKey] as? String else { return nil }
        lastName = LastName
        guard let MapString = parseResult[Constants.mapStringKey] as? String else { return nil }
        mapString = MapString
        guard let MediaURL = parseResult[Constants.mediaURLKey] as? String else { return nil }
        mediaURL = MediaURL
        guard let Longitude = parseResult[Constants.longitudeKey] as? Double else { return nil }
        longitude = Longitude
        guard let Latitude = parseResult[Constants.latitudeKey] as? Double else { return nil }
        latitude = Latitude
        guard let UpdatedAt = parseResult[Constants.updatedAtKey] as? String else { return nil }
        updatedAt = UpdatedAt
    }

    static func getLocations(from results: [[String:AnyObject]]) -> [StudentInformation] {
        var studentInformations = [StudentInformation]()
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            if let studentInformation = StudentInformation(result) {
                studentInformations.append(studentInformation)
            }
        }
        return studentInformations
    }
}

extension StudentInformation {
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = latitude,
            let longitude = longitude else {
                return nil
        }
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude),
                                      longitude: CLLocationDegrees(longitude))
    }
    
}
