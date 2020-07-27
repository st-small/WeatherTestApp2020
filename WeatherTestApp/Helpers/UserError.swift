//
//  UserError.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

enum UserError {
    case cantGetForecast
    case forecastTemperatureMissing
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .cantGetForecast:
            return NSLocalizedString("Can't get weather forecast", comment: "")
        case .forecastTemperatureMissing:
            return NSLocalizedString("Weather forecast data has wrong value", comment: "")
        }
    }
}
