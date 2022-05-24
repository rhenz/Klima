//
//  WeatherResponseError.swift
//  Klima
//
//  Created by John Salvador on 5/15/22.
//

import Foundation

enum WeatherResponseError: Error {
    case noWeatherDataAvailable
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    
    func alertTitleAndMessage() -> (title: String, message: String) {
        switch self {
        case .noWeatherDataAvailable:
            let title = "Unable to Fetch Weather Data"
            let message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
            return (title, message)
            
        case .notAuthorizedToRequestLocation:
            let title = "Unable to Fetch Weather Data for Your Location"
            let message = "Rainstorm is not authorized to access your current location. This means it's unable to show you the weather for your current location. You can grant Rainstorm access to your current location in the Settings application."
            return (title, message)
            
        case .failedToRequestLocation:
            let title = "Unable to Fetch Weather Data for Your Location"
            let message = "Rainstorm is not able to fetch your current location due to a technical issue."
            return (title, message)
        }
    }
}
