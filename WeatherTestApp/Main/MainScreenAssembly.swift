//
//  MainScreenAssembly.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class MainScreenAssembly {
    
    private var viewController: MainScreenView?
    
    public var view: MainScreenView {
        guard let view = viewController else {
            self.viewController = MainScreenView.instantiateFromXib()
            self.configureModule(self.viewController!)
            return self.viewController!
        }
        return view
    }
    
    private func configureModule(_ view: MainScreenView) {
        view.viewModel = MainScreenModel()
    }
}
