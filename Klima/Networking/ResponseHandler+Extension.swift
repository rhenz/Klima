//
//  ResponseHandler+Extension.swift
//  Klima
//
//  Created by John Salvador on 5/21/22.
//

import Foundation

struct ServiceError: Error, Codable {
    let HTTPStatus: Int
    let message: String
}

extension ResponseHandler {
    func parse<T: Codable>(data: Data, response: HTTPURLResponse, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            let body = try decoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(HTTPStatus: response.statusCode, message: "Unknown Error")
            }
        } catch  {
            throw ServiceError(HTTPStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}
