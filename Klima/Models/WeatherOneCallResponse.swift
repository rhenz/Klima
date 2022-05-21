//
//  WeatherOneCallResponse.swift
//  Klima
//
//  Created by John Salvador on 5/15/22.
//

import Foundation

struct WeatherOneCallResponse: Codable {
    let lat: Double
    let lon: Double
    let currently: Conditions
    let daily: [Daily.Conditions]
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case currently = "current"
        case daily
    }
    
    struct Conditions: Codable {
        let date: Date
        let sunrise: Date
        let sunset: Date
        let temp: Double
        let humidity: Double
        let uvi: Double
        let windSpeed: Double
        let weather: [Weather]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case sunrise
            case sunset
            case temp
            case humidity
            case uvi
            case windSpeed = "wind_speed"
            case weather
        }
    }
    
    struct Weather: Codable {
        let main: String
        let description: String
        let icon: String
    }
    
    struct Daily: Codable {
        
        struct Conditions: Codable {
            let date: Date
            let sunrise: Double
            let sunset: Double
            let temp: Temperature
            let windSpeed: Double
            let weather: [Weather]
            
            
            struct Temperature: Codable {
                let min: Double
                let max: Double
            }
            
            enum CodingKeys: String, CodingKey {
                case date = "dt"
                case sunrise
                case sunset
                case temp
                case windSpeed = "wind_speed"
                case weather
            }
        }
        
        struct Weather: Codable {
            let main: String
            let description: String
            let icon: String
        }
    }
}

extension WeatherOneCallResponse: WeatherData {
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var latitude: Double {
        return lat
    }
    
    var longitude: Double {
        return lon
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily
    }
}

extension WeatherOneCallResponse.Conditions: CurrentWeatherConditions {
    var summary: String {
        return (weather.first?.description ?? "").capitalized
    }
    
    var temperature: Double {
        return temp
    }
    
    var time: Date {
        return date
    }
    
    var icon: String {
        return weather.first?.icon ?? ""
    }
}

extension WeatherOneCallResponse.Daily.Conditions: ForecastWeatherConditions {
    var temperatureMin: Double {
        return temp.min
    }
    
    var temperatureMax: Double {
        return temp.max
    }
    
    var time: Date {
        return date
    }
    
    var icon: String {
        return weather.first?.icon ?? ""
    }
}
