//
//  APIRequestDataProvider.swift
//  ULife
//
//  Created by iMac on 7/30/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import Alamofire

let kClientVersionHeaderField = "os_version"
let kClientOSHeaderField = "os_type"
let apiVersion = ""

enum APIMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum APIBodyDataType {
    case FormData
    case JSONData
    case QuerryString
    
    var dataType: ParameterEncoding {
        switch self {
        case .FormData:
            return URLEncoding.httpBody
        case .JSONData:
            return JSONEncoding.default
        case .QuerryString:
            return URLEncoding.queryString
        }
    }
}

class APIRequestDataProvider: NSObject {

    //mark: SINGLETON
    static var shareInstance: APIRequestDataProvider = {
        let instance = APIRequestDataProvider()
        return instance
    }()
    
    //mark: DEFAULT HEADER & REQUEST URL
    var headersJSON: HTTPHeaders {
        get {
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Transfer-Encoding": "chunked"
            ]

            return headers
        }
    }
    
    var headersFormData: HTTPHeaders {
        get {
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
                "Transfer-Encoding": "chunked"
            ]

            return headers
        }
    }
    
    lazy var alamoFireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30 // seconds for testing

        let _alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        return _alamoFireManager
    }()
    
    func requestWithParams(baseURL: String,
                           apiURL: String,
                           params: Dictionary<String, Any>,
                           method: APIMethod,
                           bodyDataType: APIBodyDataType) -> DataRequest {
        let urlString = baseURL.appending(apiURL)
        let map: [APIMethod: HTTPMethod] = [.POST:.post,
                                            .GET: .get,
                                            .DELETE: .delete,
                                            .PUT:.put]
        
        return alamoFireManager.request(urlString,
                                        method: map[method]!,
                                        parameters: params,
                                        encoding: bodyDataType.dataType,
                                        headers: bodyDataType == .FormData ? self.headersFormData : self.headersJSON)
    }
}
