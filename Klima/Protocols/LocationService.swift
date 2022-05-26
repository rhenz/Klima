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
    typealias LocationServiceResult = Result<Location?, LocationServiceError>
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    // MARK: - Methods
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
