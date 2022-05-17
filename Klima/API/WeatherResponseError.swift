//
//  WeatherResponseError.swift
//  Klima
//
//  Created by John Salvador on 5/15/22.
//

import Foundation

enum WeatherResponseError: Error {
    case noWeatherDataAvailable
    
    func alertTitleAndMessage() -> (title: String, message: String) {
        switch self {
        case .noWeatherDataAvailable:
            let title = "Unable to Fetch Weather Data"
            let message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
            return (title, message)
        }
    }
}
