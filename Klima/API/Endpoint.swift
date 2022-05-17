//
//  Endpoint.swift
//  Klima
//
//  Created by John Salvador on 5/15/22.
//

import Foundation
import CoreLocation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    private var baseURL: URL {
        WeatherService.baseUrl
    }
}


extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
