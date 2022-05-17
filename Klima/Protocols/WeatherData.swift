//
//  WeatherData.swift
//  Klima
//
//  Created by John Salvador on 5/16/22.
//

import Foundation

protocol WeatherData {
    
    var latitude: Double { get }
    var longitude: Double { get }
    
    var current: CurrentWeatherConditions { get }
    var forecast: [ForecastWeatherConditions] { get }
}

protocol WeatherConditions {
    var time: Date { get }
    var icon: String { get }
    var windSpeed: Double { get }
}

protocol CurrentWeatherConditions: WeatherConditions {
    var summary: String { get }
    var temperature: Double { get }
}

protocol ForecastWeatherConditions: WeatherConditions {
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
}
