//
//  AppData.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 27.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct AppData {
    @Storage(key: "city_comment", defaultValue: "")
    static var cityComment: String
}
