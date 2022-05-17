//
//  Configuration.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation
import CoreLocation

enum Defaults {
    
    // Manila
    static let location = CLLocation(latitude: 14.5995, longitude: 120.9842)
}

enum WeatherService {
    static let apiKey = "a72ffc67385f25167f215ccbc8b6a880"
    static let baseUrl = URL(string: "https://api.openweathermap.org")!
    
    static let units = "imperial" // imperial, metric
}


enum WeatherIconSystemImage {
    static let clearSky = "sun.min"
    static let cloudy = "cloud"
    static let showerRain = "cloud.drizzle"
    static let rain = "cloud.rain"
    static let thunderstorm = "cloud.bolt"
    static let snow = "cloud.snow"
    static let fog = "cloud.fog"
}
