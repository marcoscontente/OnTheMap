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
}
