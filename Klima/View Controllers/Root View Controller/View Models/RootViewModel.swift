//
//  RootViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation

class RootViewModel {
    typealias DidFetchWeatherDataCompletion = (Result<WeatherData, WeatherResponseError>) -> Void
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    // MARK: - Init
    init() {
        fetchWeatherData()
    }
    
    // MARK: -
    func fetchWeatherData() {
        let request = OnecallWeatherAPI(location: Defaults.location)
        
        APILoader(apiHandler: request).loadAPIRequest { [weak self] response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data: \(error)")
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                } else if let response = response {
                    self?.didFetchWeatherData?(.success(response))
                } else {
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                }
            }
        }
    }
}
