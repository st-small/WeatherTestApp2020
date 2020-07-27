//
//  DetailScreenAssembly.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class DetailScreenAssembly {
    
    private var viewController: DetailScreenView?
    private var location: LocationAddress
    private var forecast: ForecastModel
    
    public var view: DetailScreenView {
        guard let view = viewController else {
            self.viewController = DetailScreenView.instantiateFromXib()
            self.configureModule(self.viewController!)
            return self.viewController!
        }
        return view
    }
    
    init(location: LocationAddress, forecast: ForecastModel) {
        self.location = location
        self.forecast = forecast
    }
    
    private func configureModule(_ view: DetailScreenView) {
        view.viewModel = DetailScreenModel(location: location, forecast: forecast)
    }
}
