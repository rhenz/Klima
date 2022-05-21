//
//  RequestHandler+Extension.swift
//  Klima
//
//  Created by John Salvador on 5/21/22.
//

import Foundation

extension RequestHandler {    
    func setQueryParams(parameters: [String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
        return components?.url ?? url
    }
    
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(APIHeaders.contentTypeValue, forHTTPHeaderField: APIHeaders.kContentType)
    }
    
    func setHTTPMethod(for request: inout URLRequest, httpMethod: HTTPMethod) {
        request.httpMethod = httpMethod.value
    }
}
