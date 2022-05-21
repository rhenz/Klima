//
//  WeekDayViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/19/22.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    let weatherData: ForecastWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var day: String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f °F", weatherData.temperatureMin)
        let max = String(format: "%.1f °F", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }

    var image: UIImage? {
        do {
            let image = try WeatherIcon.getSystemImage(for: weatherData.icon)
            return image
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
