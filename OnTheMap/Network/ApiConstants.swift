//
//  ApiConstants.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 14/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation


struct ParseKeys {
    let baseUrl: String = "https://parse.udacity.com/parse/classes"
    let parseId: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let apiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
}

struct ParseObjectKey {
    let studentLocation = "StudentLocation"
    let studentInformation = "StudentInformation"
}

struct Methods {
    let get = "GET"
    let post = "POST"
    let put = "PUT"
}

struct ParseParameterKeys {
    let limit = "limit"
    let skip = "skip"
    let order = "order"
    let objectId = "objectId"
    let uniqueKey = "uniqueKey"
}

struct ParseResponseKeys {
    let results = "results"
    let createdAt = "createdAt"
    let objectId = "objectId"
    let firstName = "firstName"
    let lastName = "lastName"
    let latitude = "latitude"
    let longitude = "longitude"
    let mapString = "mapString"
    let mediaURL = "mediaURL"
    let uniqueKey = "uniqueKey"
    let updatedAt = "updatedAt"
}

struct UdacityKeys {
    let baseUrl: String = "https://onthemap-api.udacity.com/v1/session"
}

struct UdacityParametersKeys {
    let udacity = "udacity"
    let username = "username"
    let password = "password"
}








