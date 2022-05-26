//
//  NetworkManager.swift
//  Klima
//
//  Created by John Salvador on 5/26/22.
//

import Foundation

class NetworkManager: NetworkService {
    
    // MARK: - Network Service
    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }
}
