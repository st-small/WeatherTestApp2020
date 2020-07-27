//
//  NetworkService.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class NetworkService {
    
    public static let shared = NetworkService()
    
    private init() { }
    
    public func getForecast(location: GeoLocation, completion: @escaping (Result<Double, Error>) -> Void) {
        guard var components = URLComponents(string: Constants.URLs.weatherURL) else {
            completion(.failure(UserError.cantGetForecast))
            return
        }
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "appId", value: Constants.Keys.weatherKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard let url = components.url else {
            completion(.failure(UserError.cantGetForecast))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let forecast = try JSONDecoder().decode(WeatherResponse.self, from: data)
                guard let temperature = forecast.main?.temp else {
                    completion(.failure(UserError.forecastTemperatureMissing))
                    return
                }
                completion(.success(temperature))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
