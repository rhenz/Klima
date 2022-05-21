//
//  WeekViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/16/22.
//

import Foundation

struct WeekViewModel {
    
    // MARK: - Properties
    let weatherData: [ForecastWeatherConditions]
    
    // MARK: -
    
    var numberOfDays: Int {
        weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}

extension WeekDayViewModel: WeekDayRepresentable {
    
}
