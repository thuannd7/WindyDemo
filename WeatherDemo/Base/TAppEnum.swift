//
//  TAppEnum.swift
//  Utils
//
//  Created by Macintosh on 10/3/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import UIKit

enum AppDateFormat {
    case defaultFormat
    case monthYear1
    case monthYear2
    
    func format() -> String {
        switch self {
        case .monthYear1:
            return "MMMM, yyyy"
        case .monthYear2:
            return "MM/yyyy"
        default:
            return "dd/MM/yyyy"
        }
    }
}
