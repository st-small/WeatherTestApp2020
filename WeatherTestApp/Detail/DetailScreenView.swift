//
//  DetailScreenView.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class DetailScreenView: BaseViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var city: UILabel!
    @IBOutlet private weak var country: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var commentField: UITextField!
    @IBOutlet private weak var commentLabel: UILabel!

    // MARK: - Data
    public var viewModel: DetailScreenModel! {
        didSet {
            viewModel.locationAddress.bind { [weak self] location in
                DispatchQueue.main.async {
                    self?.country.text = location?.country ?? "--"
                    self?.city.text = location?.city ?? "--"
                }
            }
            
            viewModel.forecast.bind { [weak self] forecast in
                DispatchQueue.main.async {
                    if let tempreatureValue = forecast?.temperature {
                        self?.temperature.text = "\(tempreatureValue)º"
                    }
                }
            }
            
            viewModel.cityComment.bind { [weak self] text in
                DispatchQueue.main.async {
                    self?.commentLabel.text = text
                }
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        country.text = viewModel.locationAddress.value?.country ?? "--"
        city.text = viewModel.locationAddress.value?.city ?? "--"
        if let tempreatureValue = viewModel.forecast.value?.temperature {
            temperature.text = "\(tempreatureValue)º"
        }
        
        viewModel.getUsersComment()
        commentField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailScreenView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.updateUsersComment(text: textField.text ?? "")
        textField.text = nil
        view.endEditing(true)
        return true
    }
}
