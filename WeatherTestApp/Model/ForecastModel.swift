//
//  ForecastModel.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct ForecastModel {
    public var temperature: Int?
    public var temperatureDescription: String
    
    init(temperature: Int? = nil,
        temperatureDescription: String = "") {
        self.temperature = temperature
        self.temperatureDescription = temperatureDescription
    }
}
