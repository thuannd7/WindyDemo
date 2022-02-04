//
//  LocationServiceTests.swift
//  WeatherDemoTests
//
//  Created by Thuan Nguyen on 23/01/2022.
//

import XCTest
import CoreLocation
@testable import WeatherDemo

class LocationServiceTests: XCTestCase {

    var locationHelper: LocationHelper?
    var service: WeatherService?
    let lat = 21.0245 // of Ha Noi, Viet nam
    let long = 105.841171 // of Ha Noi, Viet Nam
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func setUp() {
       super.setUp()
        locationHelper = LocationHelper()
        service = WeatherService()
    }

    override func tearDown() {
       super.tearDown()
        locationHelper = nil
        service = nil
    }
    
    func testGetCurrentLocationData() {
        guard let locationHelper = locationHelper else {
            XCTAssertTrue(false)
            return
        }
        
        locationHelper.getCurrentLocation { (location: CLLocation) in
            XCTAssertTrue(true)
        } _: { (status: CLAuthorizationStatus) in
            DLog("false: \(status)")
            XCTAssertTrue(false)
        }
    }
    
    func testGetWeatherOfLocation() {
        guard let service = service else {
            XCTAssertTrue(false)
            return
        }
        
        let promise = expectation(description: "Completion handler invoked")
        service.getWeatherCurrentLocation(lat: "\(lat)", long: "\(long)",
                                          complete: { (data: LocationWeatherDataModel) in
                                            DLog("data: \(data)")
                                            promise.fulfill()
                                            XCTAssertTrue(true)
                                          },
                                          failse: { (err: Error) in
                                            promise.fulfill()
                                            XCTFail("Error: \(err.localizedDescription)")
                                          })
        wait(for: [promise], timeout: 30.0)
    }
    
    func testGetForecastWeatherOfLocation () throws {
        guard let service = service else {
            XCTAssertTrue(false)
            return
        }
        
        let promise = expectation(description: "Completion handler invoked")
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { (data: ForecastWeatherDataModel) in
            DLog("data: \(data)")
            promise.fulfill()
            XCTAssertTrue(true)
        } failse: { (err: Error?) in
            DLog("err: \(String(describing: err?.localizedDescription))")
            promise.fulfill()
            XCTFail("Error: \(err?.localizedDescription ?? "")")
        }
        
        wait(for: [promise], timeout: 30.0)
    }
    
    func testWindDegSymbol() {
        doTestWindDegSymbol(0.0, 0.0, "N")
        doTestWindDegSymbol(0.0, 45.0, "NNE")
        doTestWindDegSymbol(45.0, 45.0, "NE")
        doTestWindDegSymbol(45.0, 90.0, "ENE")
        doTestWindDegSymbol(90.0, 90.0, "E")
        doTestWindDegSymbol(90.0, 135.0, "ESE")
        doTestWindDegSymbol(135.0, 135.0, "SE")
        doTestWindDegSymbol(135.0, 180.0, "SSE")
        doTestWindDegSymbol(180.0, 180.0, "S")
        doTestWindDegSymbol(180.0, 225.0, "SSW")
        doTestWindDegSymbol(225.0, 225.0, "SW")
        doTestWindDegSymbol(225.0, 270.0, "WSW")
        doTestWindDegSymbol(270.0, 270.0, "W")
        doTestWindDegSymbol(270.0, 315.0, "WW")
        doTestWindDegSymbol(315.0, 315.0, "NW")
        doTestWindDegSymbol(315.0, 360.0, "NNW")
        doTestWindDegSymbol(360.0, 360.0, "N")
    }
    
    func doTestWindDegSymbol(_ deg_0: Double, _ deg_1: Double, _ symbol: String) {
        XCTAssertTrue(((deg_0 + deg_1)*0.5).windDegSymbol == symbol)
    }
}
