//
//  OnecallWeatherAPI.swift
//  Klima
//
//  Created by John Salvador on 5/21/22.
//

import Foundation
import CoreLocation

struct OnecallWeatherAPI: APIHandler {
   
    // MARK: - Properties
    var location: CLLocation
    
    private var latitude: Double {
        location.coordinate.latitude
    }
    
    private var longitude: Double {
        location.coordinate.longitude
    }
    
    private var queryParams: [String : Any] {
        return [
            "lat": latitude,
            "lon": longitude,
            "units": WeatherService.units,
            "appid": WeatherService.apiKey
        ]
    }
    
    // MARK: -
    func makeRequest() -> URLRequest? {
        if var url = APIPath.onecall {
            url = setQueryParams(parameters: queryParams, url: url)
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            setHTTPMethod(for: &urlRequest, httpMethod: .get)
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> WeatherOneCallResponse {
        return try parse(data: data, response: response)
    }
}