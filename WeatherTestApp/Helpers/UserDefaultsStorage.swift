//
//  UserDefaultsStorage.swift
//  WeatherTestApp
//
//  Created by Stanly Shiyanovskiy on 27.07.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Storage<T: Codable> {

    struct Wrapper<T>: Codable where T: Codable {
        let wrapped: T
    }

    private let key: String
    private let defaultValue: T

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(Wrapper<T>.self, from: data)
            return value?.wrapped ?? defaultValue
        }
        set {
            do {
                // Convert newValue to data
                let data = try JSONEncoder().encode(Wrapper(wrapped: newValue))

                // Set value to UserDefaults
                UserDefaults.standard.set(data, forKey: key)
            } catch {
                print(error)
            }
        }
    }
}
