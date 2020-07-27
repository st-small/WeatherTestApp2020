//
//  DetailScreenModel.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class DetailScreenModel {
    
    // MARK: - Data
    public let locationAddress: Dynamic<LocationAddress?>
    public let forecast: Dynamic<ForecastModel?>
    public var cityComment: Dynamic<String>
    
    init(location: LocationAddress? = nil, forecast: ForecastModel? = nil) {
        self.locationAddress = Dynamic(location)
        self.forecast = Dynamic(forecast)
        self.cityComment = Dynamic(AppData.cityComment)
    }
    
    public func getUsersComment() {
        cityComment.value = AppData.cityComment
    }
    
    public func updateUsersComment(text: String) {
        guard !text.isEmpty else { return }
        AppData.cityComment = text
        getUsersComment()
    }
}
