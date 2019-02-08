//
//  Error.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 30/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

enum ErrorCode: Int {
    case unknown = -111
    case unexpected = -999
}

enum ErrorMessage: String {
    case unknown = "An unknown error has occured. Try again later."
    case unexpected = "An unexpected error has occured. Check your internet connection and try again."
    case couldNotLoadUserData = "Could not load user data."
    case invalidEmailOrPassword = "Invalid e-mail or password."
    case invalidFacebookLogin = "Fail to login using facebook"
    case invalidUdacityLogin = "Fail to login using udacity"
    case noMatchingLocationFound = "No Matching Location Found"
    case unableToFindLocationForAddress = "Unable to Find Location for Address"
    case invalidLink = "Invalid link."
    case invalidAddress = "Invalid address."
    case couldNotLoadData = "Could not load data."
    case couldNotOpenURL = "Sorry, we could'n open URL, try again later."
}
