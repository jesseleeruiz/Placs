//
//  City.swift
//  Placs
//
//  Created by Jesse Ruiz on 8/31/20.
//  Copyright © 2020 Jesse Ruiz. All rights reserved.
//

import Foundation
import CoreLocation

struct City: Comparable {
    var name: String
    var country: String
    var coordinates: CLLocationCoordinate2D
    
    var formattedName: String {
        return "\(name) (\(country))"
    }
    
    static func <(lhs: City, rhs: City) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
    
    func matches(_ text: String) -> Bool {
        return name.localizedCaseInsensitiveContains(text) || country.localizedCaseInsensitiveContains(text)
    }
}
