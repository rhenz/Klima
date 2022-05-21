//
//  DayViewModelTests.swift
//  KlimaTests
//
//  Created by John Salvador on 5/18/22.
//

import XCTest
@testable import Klima

class DayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: DayViewModel!

    // MARK: - Set Up & Tear Down
    override func setUpWithError() throws {
        // Load Stub
        let data = loadStub(name: "klima", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Open Weather Map Response
        let response = try! decoder.decode(WeatherOneCallResponse.self, from: data)
        
        // Initialize View Model
        viewModel = DayViewModel(weatherData: response.current)
    }

    override func tearDownWithError() throws {
        
    }
    
    // Tests for Date
    func test_date() {
        XCTAssertEqual(viewModel.date, "Wed, May 18 2022")
    }
    
    
    // Test for Time
    func test_time() {
        // Date from our json stub
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let time = Date(timeIntervalSince1970: 1652877784)
        let timeString = dateFormatter.string(from: time)
        
        XCTAssertEqual(viewModel.time, timeString)
    }
    
    // Test for Summary
    func test_summary() {
        let weatherSummaryFromJSON = "Moderate Rain"
        XCTAssertEqual(viewModel.summary, weatherSummaryFromJSON)
    }
    
    // Test for Temperature
    func test_temperature() {
        XCTAssertEqual(viewModel.temperature, "79.5 °F")
    }
    
    // Test for Wind Speed
    func test_windSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "2 MPH")
    }
    
    // Test for Image
    func test_image() {
        guard let data1 = viewModel.image?.pngData(), let data2 = UIImage(systemName: "cloud.rain")?.pngData() else {
            XCTFail("Image Data should not be nil.")
            return
        }
        
        XCTAssertEqual(data1, data2)
    }
}
