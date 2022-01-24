//
//  APIRequestService.swift
//  ULife
//
//  Created by iMac on 7/30/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

typealias APIRequestSuccessBlock = (_ jsonData: JSON) -> Void
typealias APIRequestFailBlock = (_ error: Error) -> Void

enum REQUEST_STATUS_CODE: Int {
    case UN_AUTHENT = 400
    case ACCESSTOKEN_EXPIRE = 401
    case NO_PERMISSION = 403
}

class APIBaseRequestService: NSObject {
    
    func sendRequest(_ request: DataRequest,
                     _ success: APIRequestSuccessBlock?,
                     _ fail: APIRequestFailBlock?) {
        request
            .validate()
            .responseJSON { (_ response: DataResponse<Any>) in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    success?(json)
                    break
                case .failure(let error as NSError):
                    DLog("=========================================")
                    
                    var statusCode = response.response?.statusCode
                    if let error = response.result.error as? AFError {
                        statusCode = error._code // statusCode private
                        switch error {
                        case .invalidURL(let url):
                            DLog("Invalid URL: \(url) - \(error.localizedDescription)")
                        case .parameterEncodingFailed(let reason):
                            DLog("Parameter encoding failed: \(error.localizedDescription)")
                            DLog("Failure Reason: \(reason)")
                        case .multipartEncodingFailed(let reason):
                            DLog("Multipart encoding failed: \(error.localizedDescription)")
                            DLog("Failure Reason: \(reason)")
                        case .responseValidationFailed(let reason):
                            DLog("Response validation failed: \(error.localizedDescription)")
                            DLog("Failure Reason: \(reason)")

                            switch reason {
                            case .dataFileNil, .dataFileReadFailed:
                                DLog("Downloaded file could not be read")
                            case .missingContentType(let acceptableContentTypes):
                                DLog("Content Type Missing: \(acceptableContentTypes)")
                            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                                DLog("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                            case .unacceptableStatusCode(let code):
                                DLog("Response status code was unacceptable: \(code)")
                                statusCode = code
                            }
                        case .responseSerializationFailed(let reason):
                            DLog("Response serialization failed: \(error.localizedDescription)")
                            DLog("Failure Reason: \(reason)")
                            // statusCode = 3840 ???? maybe..
                        }

                        DLog("Underlying error: \(String(describing: error.underlyingError))")
                    } else if let error = response.result.error as? URLError {
                        DLog("URLError occurred: \(error)")
                    } else {
                        DLog("Unknown error: \(String(describing: response.result.error))")
                    }
                    
                    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
                        fail?(NSError(domain: error.domain, code: statusCode ?? error.code, userInfo: nil))
                    } else if error.code == NSURLErrorCancelled {
                        fail?(NSError(domain: error.domain, code: statusCode ?? error.code, userInfo: nil))
                    } else if statusCode == REQUEST_STATUS_CODE.NO_PERMISSION.rawValue {
                        let userInfo: [String : Any] = [NSLocalizedDescriptionKey:  "Không có quyền",
                                                        NSLocalizedFailureReasonErrorKey: "Không có quyền"]
                        let _err = NSError(domain: error.domain, code: statusCode ?? error.code, userInfo: userInfo)
                        fail?(_err)
                    } else {
                        let _err = NSError(domain: error.domain, code: statusCode ?? error.code, userInfo: error.userInfo)
                        fail?(_err)
                    }
                    
                    break
                default:
                    break
                }
        }
    }
}
