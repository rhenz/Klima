//
//  RootViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation
import CoreLocation

class RootViewModel: NSObject {
    typealias DidFetchWeatherDataCompletion = (Result<WeatherData, WeatherResponseError>) -> Void
    
    // MARK: - Properties
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager Delegate
        locationManager.delegate = self
        return locationManager
    }()
    
    // MARK: - Init
    override init() {
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        // Fetch Location
        fetchLocation()
    }
    
    
    // MARK: -
    private func fetchWeatherData(for location: CLLocation) {
        let request = OnecallWeatherAPI(location: location)
        
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
    
    private func fetchLocation() {
        // Request Location
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension RootViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .notDetermined {
            // Request for Authorization
            locationManager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .authorizedWhenInUse {
            // Fetch Location
            fetchLocation()
        } else {
            // Invoke completion handler
            didFetchWeatherData?(.failure(.notAuthorizedToRequestLocation))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // Fetch Weather Data
        fetchWeatherData(for: location)
    }
}
