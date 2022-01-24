//
//  DictionaryExtension.swift
//  Utils
//
//  Created by Macintosh on 10/2/18.
//  Copyright © 2018 Macintosh. All rights reserved.
//

import Foundation

extension NSDictionary {
    func stringValueWithKey(_ key: String)-> String {
        if let value = self.value(forKey: key) as? String {
            return value
        }
        return ""
    }
    
    func stringWithKey(_ key: String)-> String? {
        if let value = self.value(forKey: key) as? String {
            return value
        }
        return nil
    }
    
    func boolWithKey(_ key: String)-> Bool {
        if let value = self.value(forKey: key) as? String {
            return value == "1"
        }
        
        return false
    }
    
    func numberValueWithKey(_ key: String)-> NSNumber {
        if let value = self.value(forKey: key) as? NSNumber {
            return value
        }
        return NSNumber(integerLiteral: 0)
    }
    
    func numberWithKey(_ key: String)-> NSNumber? {
        if let value = self.value(forKey: key) as? NSNumber {
            return value
        }
        return nil
    }
    
    func doubleValueWithKey(_ key: String)-> Double {
        if let value = self.value(forKey: key) as? String {
            return Double(value) ?? 0.0
        }
        return 0.0
    }
    
    func intValueWithKey(_ key: String)-> Int {
        if let value = self.value(forKey: key) as? NSNumber {
            return value.intValue
        }
        return 0
    }
    
    static var dictCategoryThuNo: NSDictionary {
        let dict = NSMutableDictionary()
        dict["uid"]     = "thu_no"
        dict["name"]    = "Thu nợ"
        dict["type"]    = "debt_loan"
        dict["parentCategoryUid"]   = ""
        dict["transactionType"]     = "income"
        dict["deploanType"]         = "thu_no"
        return dict
    }
    
    static var dictCategoryTraNo: NSDictionary {
        let dict = NSMutableDictionary()
        dict["uid"]     = "tra_no"
        dict["name"]    = "Trả nợ"
        dict["type"]    = "debt_loan"
        dict["parentCategoryUid"]   = ""
        dict["transactionType"]     = "outcome"
        dict["deploanType"]         = "tra_no"
        return dict
    }
}
