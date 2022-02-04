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
    
    func testSportFasterThanJeep() {
        locationHelper?.getCurrentLocation { (location: CLLocation) in
            XCTAssertTrue(true)
        } _: { (status: CLAuthorizationStatus) in
            XCTAssertTrue(false)
        }
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
        
        service.getWeatherCurrentLocation(lat: "\(lat)", long: "\(long)",
                                          complete: { (data: LocationWeatherDataModel) in
                                            DLog("data: \(data)")
                                            XCTAssertTrue(true)
                                          },
                                          failse: { (err: Error) in
                                            XCTAssertTrue(false)
                                          }
        )
    }
    
    func testGetForecastWeatherOfLocation () {
        guard let service = service else {
            XCTAssertTrue(false)
            return
        }
        
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { (data: ForecastWeatherDataModel) in
            DLog("data: \(data)")
            XCTAssertTrue(true)
        } failse: { (err: Error?) in
            DLog("err: \(String(describing: err?.localizedDescription))")
            XCTAssertTrue(false)
        }
    }
}
