//
//  WeekViewModelTests.swift
//  KlimaTests
//
//  Created by John Salvador on 5/20/22.
//

import XCTest
@testable import Klima

class WeekViewModelTests: XCTestCase {
    
    var viewModel: WeekViewModel!

    override func setUpWithError() throws {
        
        let data = loadStub(name: "klima", extension: "json")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let response = try! decoder.decode(WeatherOneCallResponse.self, from: data)
        
        viewModel = WeekViewModel(weatherData: response.forecast)
    }
    

    override func tearDownWithError() throws {
        
    }

    
    // MARK: - Tests
    func test_numberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func test_viewModelForIndex() {
        // Stubbed JSON date starts May 18, 2022 Wednesday
        let weekDayViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weekDayViewModel.day, "Monday")
        XCTAssertEqual(weekDayViewModel.date, "May 23")
    }
    
    
}
