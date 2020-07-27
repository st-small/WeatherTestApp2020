//
//  LocationManager.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 24.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import CoreLocation
import Foundation

public protocol LocationManagerDelegate: class {
    func getPlace(address: LocationAddress?)
    func getLocation(location: GeoLocation)
}

public class LocationManager: NSObject {
    
    // MARK: - Private
    private let locationManager = CLLocationManager()
    
    // MARK: - API
    public weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}


// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .notDetermined, .restricted:
            locationManager.stopUpdatingLocation()
        @unknown default: assertionFailure("Location manager status is unknown!")
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else { return }
        getPlace(for: last)
    }
}

// MARK: - Get Placemark
extension LocationManager {
    private func getPlace(for location: CLLocation) {
        delegate?.getLocation(location:
            GeoLocation(latitude: location.coordinate.latitude,
                        longitude: location.coordinate.longitude))
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                self.delegate?.getPlace(address: nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                self.delegate?.getPlace(address: nil)
                return
            }
            
            var address = LocationAddress()
            if let country = placemark.country {
                address.country = country
            }
            
            if let city = placemark.locality {
                address.city = city
            }
            self.delegate?.getPlace(address: address)
        }
    }
}
