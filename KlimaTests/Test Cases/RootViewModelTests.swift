//
//  RootViewModelTests.swift
//  KlimaTests
//
//  Created by John Salvador on 5/26/22.
//

import XCTest
@testable import Klima

class RootViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: RootViewModel!

    override func setUpWithError() throws {
        // Initialize Root View Model
        viewModel = RootViewModel(locationService: MockLocationService())
    }

    func test_refresh() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { result in
            if case let .success(weatherData) = result {
                print("Printing Weather Data...")
                print(weatherData)

                // Fulfill Expectation
                expectation.fulfill()
            }
            
        }
        
        // Invoke Method Under Test
        viewModel.refresh()
        
        // Wait for Expectation to be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

}
