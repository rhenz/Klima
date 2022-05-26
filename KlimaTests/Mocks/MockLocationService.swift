//
//  MockLocationService.swift
//  KlimaTests
//
//  Created by John Salvador on 5/26/22.
//

import Foundation
@testable import Klima

class MockLocationService: LocationService {
    
    // MARK: - Properties
    // 14.6052261,121.0892593
    var location: Location = Location(latitude: 14.6052261, longitude: 121.0892593)
    
    var delay: TimeInterval = 0.0
    
    // MARK: - Location Service
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        // Create A Result
        let result: LocationServiceResult = .success(location)
//        let result: LocationServiceResult = .failure(.notAuthorizedToRequestLocation) // For Error
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Invoke Handler
            completion(result)
        }
    }
    
    
}
