//
//  WeatherRequest.swift
//  Klima
//
//  Created by John Salvador on 5/14/22.
//

import Foundation
import CoreLocation

/*
struct WeatherRequest {
    let baseURL: URL
    let location: CLLocation
    
    var latitude: Double {
        return location.coordinate.latitude
    }
    
    var longitude: Double {
        return location.coordinate.longitude
    }
    
    private let endpoint = "/data/2.5/onecall"
    
    var url: URL? {
        var urlComponents = URLComponents(string: baseURL.absoluteString)
        urlComponents?.path = endpoint
        let queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                          URLQueryItem(name: "lon", value: "\(longitude)"),
                          URLQueryItem(name: "appid", value: WeatherService.apiKey)]
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
 */


extension Endpoint {
    static func weatherRequestOneCall(location: CLLocation) -> Endpoint {
        
        let latitude: Double = location.coordinate.latitude
        let longitude: Double = location.coordinate.longitude
        
        return Endpoint(
            path: "/data/2.5/onecall",
            queryItems: [
                URLQueryItem(name: "lat", value: "\(latitude)"),
                URLQueryItem(name: "lon", value: "\(longitude)"),
                URLQueryItem(name: "units", value: WeatherService.units),
                URLQueryItem(name: "appid", value: WeatherService.apiKey)
            ]
        )
    }
}


