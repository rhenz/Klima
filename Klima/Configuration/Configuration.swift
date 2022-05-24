//
//  Configuration.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation

enum Configuration {
    static var refreshThreshold: TimeInterval {
        #if DEBUG
        return 15.0
        #else
        return 10.0 * 60.0
        #endif
    }
}

enum Defaults {
    
    // Manila
    static let location = Location(latitude: 14.6052261, longitude: 121.0892593)
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

// API Headers
enum APIHeaders {
    static var kContentType = "Content-Type"
    static var contentTypeValue = "application/json"
}
