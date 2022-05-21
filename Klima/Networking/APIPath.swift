//
//  APIPath.swift
//  Klima
//
//  Created by John Salvador on 5/21/22.
//

import Foundation

#if DEBUG
fileprivate let environment = APIEnvironment.development
#else
fileprivate let environment = APIEnvironment.production
#endif


enum APIPath {
    
    static private let baseURL = environment.url
    
    static var onecall: URL? {
        return baseURL?.appendingPathComponent("data/2.5/onecall")
    }
}
