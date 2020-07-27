//
//  MainScreenModel.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class MainScreenModel {
    
    // MARK: - Data
    private let locationManager = LocationManager()
    public let isUIBlocked: Dynamic<Bool>
    public let error: Dynamic<String>
    public let locationAddress: Dynamic<LocationAddress>
    public let forecast: Dynamic<ForecastModel>
    
    init() {
        isUIBlocked = Dynamic(true)
        error = Dynamic("")
        locationAddress = Dynamic(LocationAddress())
        forecast = Dynamic(ForecastModel())
        locationManager.delegate = self
    }
}

extension MainScreenModel: LocationManagerDelegate {
    public func getLocation(location: GeoLocation) {
        NetworkService.shared.getForecast(location: location) { [weak self] response in
            switch response {
            case .success(let result):
                let temp = Int(result)
                self?.forecast.value.temperature = temp
                switch temp {
                case _ where temp > 10:
                    self?.forecast.value.temperatureDescription = "It's quite warm outside."
                case 0...10:
                    self?.forecast.value.temperatureDescription = "It's chilly outside."
                case _ where temp < 0:
                    self?.forecast.value.temperatureDescription = "Dress warm, it's cold outside."
                default:
                    self?.forecast.value.temperatureDescription = "Haven't any information about current weather."
                }
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    public func getPlace(address: LocationAddress?) {
        isUIBlocked.value = false
        guard let address = address else {
            error.value = "Can't get your current location"
            return
        }
        
        if let country = address.country {
            locationAddress.value.country = country
        }
        
        if let town = address.city {
            locationAddress.value.city = town
        }
    }
}
