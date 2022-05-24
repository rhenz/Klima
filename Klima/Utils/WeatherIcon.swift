//
//  WeatherIcon.swift
//  Klima
//
//  Created by John Salvador on 5/17/22.
//

import Foundation
import UIKit


enum WeatherIconError: Error {
    case unknownIcon
}

// https://openweathermap.org/weather-conditions#How-to-get-icon-URL
struct WeatherIcon {
    private init() { }
    
    public static func getSystemImage(for icon: String) throws -> UIImage  {
        switch icon {
        case "01d", "01n":
            return image(for: WeatherIconSystemImage.clearSky)
        case "02d", "02n", "03d", "03n", "04d", "04n":
            return image(for: WeatherIconSystemImage.cloudy)
        case "09d", "09n":
            return image(for: WeatherIconSystemImage.showerRain)
        case "10d", "10n":
            return image(for: WeatherIconSystemImage.rain)
        case "11d", "11n":
            return image(for: WeatherIconSystemImage.thunderstorm)
        case "13d", "13n":
            return image(for: WeatherIconSystemImage.snow)
        case "50d", "50n":
            return image(for: WeatherIconSystemImage.fog)
        default:
            throw WeatherIconError.unknownIcon
        }
    }
    
    private static func image(for systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName) else {
            fatalError("Invalid System Image Name")
        }
        
        return image
    }
}
