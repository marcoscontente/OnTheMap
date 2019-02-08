//
//  StringConstants.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 30/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

struct Constants {
    static let contentType = "Content-Type"
    static let accept = "Accept"
    static let applicationJson = "application/json"
    static let parseApplicationID = "X-Parse-Application-Id"
    static let parseApiKey = "X-Parse-REST-API-Key"
    static let parseAppIdValue = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let parseApiKeyValue = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let udacityURL = "https://onthemap-api.udacity.com/v1"
    static let parseURL = "https://parse.udacity.com/parse/classes"
    static let udacitySingUpURL = "https://auth.udacity.com/sign-up"
    static let facebookApiIdValue = ""
    static let udacityKey = "udacity\""
    static let usernameKey = "username\""
    static let passwordKey = "password\""
    static let xsrfCookieName = "XSRF-TOKEN"
    static let xsrfCookieValue = "X-XSRF-TOKEN"
    static let userPath = "/users"
    static let sessionPath = "/session"
    static let studentLocationPath = "/StudentLocation"
    static let parseParamsLimit = "limit"
    static let parseParamsSkip = "skip"
    static let parseParamsOrder = "order"
    static let parseParamsUniqueKey = "uniqueKey"
    static let parseParamsDashUpdatedAt = "-updatedAt"
    static let parseParamsUpdatedAt = "updatedAt"
    static let parseParamsLimitValue = "100"
    static let parseParamsSkipValue = "400"
    static let facebookMobileKey = "facebook_mobile\""
    static let facebookAccessTokenKey = "access_token\""
    static let HTTPMethodPost = "POST"
    static let HTTPMethodGet = "GET"
    static let HTTPMethodPut = "PUT"
    static let HTTPMethodDelete = "DELETE"

//  MARK: - Udacity Response Keys
    static let account = "account"
    static let registered = "registered"
    static let key = "key"
    static let session = "session"
    static let id = "id"
    static let expiration = "expiration"
    static let user = "user"
    static let lastName = "last_name"
    static let firstName = "first_name"
    static let status = "status"
    static let error = "error"
    static let email = "email"
    static let address = "address"


//  MARK: - Parse Student Location Response Keys
    static let studentResult = "results"
    static let createdAt = "createdAt"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
    static let mapStringKey = "mapString"
    static let mediaURLKey = "mediaURL"
    static let objectIDKey = "objectId"
    static let uniqueKeyKey = "uniqueKey"
    static let updatedAtKey = "updatedAt"
}
