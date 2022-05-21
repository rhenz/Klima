//
//  APIEnvironment.swift
//  Klima
//
//  Created by John Salvador on 5/21/22.
//

import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        return urlComponents.url
    }
    
    var scheme: String {
        switch self {
        case .development, .production, .staging:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .development, .staging, .production:
            return "api.openweathermap.org"
        }
    }
}
