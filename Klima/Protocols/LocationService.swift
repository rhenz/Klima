//
//  LocationService.swift
//  Klima
//
//  Created by John Salvador on 5/23/22.
//

import Foundation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
    case someError(String)
}

protocol LocationService {
    
    // MARK: - Type Aliases
    typealias FetchLocationCompletion = (Result<Location?, LocationServiceError>) -> Void
    
    // MARK: - Methods
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
