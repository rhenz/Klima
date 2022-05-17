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
        // Create URL
        let weatherRequest = Endpoint.weatherRequestOneCall(location: Defaults.location)
        
        guard let url = weatherRequest.url else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data: \(error)")
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let jsonData = try decoder.decode(WeatherOneCallResponse.self, from: data)
                        self?.didFetchWeatherData?(.success(jsonData))
                    } catch {
                        print("Unable to Decode JSON Response - Error: \(error)")
                        self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                    }
                    
                } else {
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                }
            }
        }.resume()
    }
}
