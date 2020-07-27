//
//  MainScreenView.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class MainScreenView: BaseViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var gradient: GradientView!
    @IBOutlet private weak var country: UILabel!
    @IBOutlet private weak var city: UIButton!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var comment: UILabel!

    // MARK: - Data
    public var viewModel: MainScreenModel! {
        didSet {
            viewModel.isUIBlocked.bind { [weak self] isBlocked in
                DispatchQueue.main.async {
                    isBlocked ? self?.lockUI() : self?.unlockUI()
                }
            }

            viewModel.error.bind { [weak self] error in
                DispatchQueue.main.async {
                    self?.showErrorAlert(error)
                }
            }
            
            viewModel.locationAddress.bind { [weak self] location in
                DispatchQueue.main.async {
                    self?.country.text = location.country ?? "--"
                    if let city = location.city {
                        self?.city.setTitle(city, for: .normal)
                        self?.city.isEnabled = true
                    }
                }
            }
            
            viewModel.forecast.bind { [weak self] forecast in
                DispatchQueue.main.async {
                    if let tempreatureValue = forecast.temperature {
                        self?.temperature.text = "\(tempreatureValue)º"
                    }
                    
                    self?.comment.text = forecast.temperatureDescription
                }
            }
        }
    }
    
    // MARK: - Services
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        gradient.setupGradient(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    }
    
    // MARK: - Actions
    @IBAction private func cityButtonTapped() {
        let assembly = DetailScreenAssembly(
            location: viewModel.locationAddress.value,
            forecast: viewModel.forecast.value)
        navigationController?.pushViewController(assembly.view, animated: true)
    }
}
