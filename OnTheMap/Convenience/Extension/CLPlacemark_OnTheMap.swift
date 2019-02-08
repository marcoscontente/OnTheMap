//
//  CLPlacemark_OnTheMap.swift
//  OnTheMap
//
//  Created by Marcos Vinicius Goncalves Contente on 05/02/19.
//  Copyright © 2019 Marcos Vinicius Goncalves Contente. All rights reserved.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    
    var mapString: String? {
        var strings = [String]()
        if let thoroughfare = self.thoroughfare {
            strings.append(thoroughfare)
        }
        if let subThoroughfare = self.subThoroughfare {
            strings.append(subThoroughfare)
        }
        if let locality = self.locality {
            strings.append(locality)
        }
        return strings.count > 0 ? strings.joined(separator: ", ") : nil
    }
    
}
