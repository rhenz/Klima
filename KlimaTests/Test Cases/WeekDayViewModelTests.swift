//
//  WeekDayViewModelTests.swift
//  KlimaTests
//
//  Created by John Salvador on 5/20/22.
//

import XCTest
@testable import Klima

class WeekDayViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: WeekDayViewModel!

    // MARK: - Init
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
        // let's get index 5 for this case, which is May 23, 2022 - Monday
        viewModel = WeekDayViewModel(weatherData: response.forecast[5])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests
    /*
     We used index 5 of the stubbed daily forecast and that is:
     May 23, 2022
     Monday
     */
    
    func test_day() {
        XCTAssertEqual(viewModel.day, "Monday")
    }
    
    func test_date() {
        XCTAssertEqual(viewModel.date, "May 23")
    }
    
    func test_temperature() {
        XCTAssertEqual(viewModel.temperature, "78.3 °F - 88.2 °F")
    }
    
    func test_windSpeed() {
        XCTAssertEqual(viewModel.windSpeed, "7 MPH")
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
