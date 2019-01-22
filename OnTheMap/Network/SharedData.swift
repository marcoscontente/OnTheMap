//
//  SharedData.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 15/01/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation

class SharedData {
    
    static let sharedInstance = SharedData()
    var studentInformations: [StudentInformation] = []
    var currentUser: StudentInformation?
    
    private init() {}
}
