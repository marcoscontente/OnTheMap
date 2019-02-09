//
//  String_OnTheMap.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 05/02/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import UIKit

extension String {
    
    var isValidUrl: Bool {
        guard let url = URL(string: self), !self.isEmpty else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func validateUrl () -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
}
