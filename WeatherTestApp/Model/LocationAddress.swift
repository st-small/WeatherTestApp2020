//
//  LocationAddress.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct LocationAddress {
    public var country: String?
    public var city: String?
    
    init(country: String? = nil,
         city: String? = nil) {
        self.country = country
        self.city = city
    }
}
