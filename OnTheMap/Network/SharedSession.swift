//
//  SharedSession.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 15/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class SharedSession {
    
    static let shared = SharedSession()
    
    // MARK: - Properties
    var studentLocations: [StudentInformation]?
    var currentUser: StudentInformation?
    var userSession: User?
    var accountKey: String?
    var sessionID: String?
    var uniqueKey: String?
    
    // MARK: - Methods
    func clearData() {
        studentLocations = nil
        currentUser = nil
        userSession = nil
        accountKey = nil
        sessionID = nil
        uniqueKey = nil
    }
}
