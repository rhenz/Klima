//
//  RootViewModel.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation
import UIKit

class RootViewModel: NSObject {
    typealias FetchWeatherDataCompletion = (Result<WeatherData, WeatherResponseError>) -> Void
    
    // MARK: - Properties
    var didFetchWeatherData: FetchWeatherDataCompletion?
    private let locationService: LocationService
    
    
    
    // MARK: - Init
    init(locationService: LocationService) {
        // Set Location Service
        self.locationService = locationService
        
        super.init()
        
        // Fetch Weather Data
        fetchWeatherData(for: Defaults.location)
        
        // Setup Notification Handling
        setupNotificationHandling()
        
        // Fetch Location
        fetchLocation()
    }
    
    // MARK: -
    private func setupNotificationHandling() {
        // Application Will Enter Foreground
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                self?.refresh()
                return
            }

            if Date().timeIntervalSince(didFetchWeatherData) > 10.0 * 60.0 {
                self?.refresh()
            }
        }
    }
    
    private func refresh() {
        fetchLocation()
    }
    
    // MARK: -
    private func fetchWeatherData(for location: Location) {
        let request = OnecallWeatherAPI(location: location)
        
        APILoader(apiHandler: request).loadAPIRequest { [weak self] response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Unable to Fetch Weather Data: \(error)")
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                } else if let response = response {
                    // Update User Defaults
                    UserDefaults.didFetchWeatherData = Date()
                    
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(.success(response))
                } else {
                    self?.didFetchWeatherData?(.failure(.noWeatherDataAvailable))
                }
            }
        }
    }
    
    private func fetchLocation() {
        // Request Location
        locationService.fetchLocation { [weak self] result in
            switch result {
            case .success(let location):
                guard let location = location else {
                    fatalError("Location was not given")
                }
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Error: \(error)")
                switch error {
                case .notAuthorizedToRequestLocation:
                    self?.didFetchWeatherData?(.failure(.notAuthorizedToRequestLocation))
                case .someError:
                    self?.didFetchWeatherData?(.failure(.failedToRequestLocation))
                }
            }
        }
    }
}



extension UserDefaults {
    // MARK: - Types
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    // MARK: - Class Computed Properties
    fileprivate class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
}
