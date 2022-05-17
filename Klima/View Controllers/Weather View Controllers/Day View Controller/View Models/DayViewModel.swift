//
//  DayViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/16/22.
//

import Foundation
import UIKit

struct DayViewModel {
    
    // MARK: - Properties
    let weatherData: CurrentWeatherConditions
    
    // MARK: -
    private let dateFormatter = DateFormatter()
    
    // MARK: -
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "EEE, MMMM d yyyy"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "hh:mm a"
        
        // Convert Date to String
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        return String(format: "%.1f °F", weatherData.temperature)
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
