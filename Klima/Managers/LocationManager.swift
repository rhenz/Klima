//
//  LocationManager.swift
//  Klima
//
//  Created by John Salvador on 5/23/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    // MARK: - Properties
    private lazy var locationManager: CLLocationManager = {
        // Initialize Location Manager
        let locationManager = CLLocationManager()
        
        // Configure Location Manager Delegate
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    // MARK: - Location Service
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        // Store Reference to Completion
        self.didFetchLocation = completion
        
        // Fetch Location
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .notDetermined {
            // Request for Authorization
            locationManager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .authorizedWhenInUse {
            // Fetch Location
            locationManager.requestLocation()
        } else {
            // Invoke completion handler
            didFetchLocation?(.failure(.notAuthorizedToRequestLocation))
            
            // Reset Completion Handler
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // Invoke Completion Handler
        didFetchLocation?(.success(Location(location: location)))
        
        // Reset Completion Handler
        didFetchLocation = nil
    }
}

fileprivate extension Location {
    
    // MARK: - Init
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}

