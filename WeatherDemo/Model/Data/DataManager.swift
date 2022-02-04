//
//  DataManager.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SwiftyJSON

class DataManager: NSObject {
    static let shared: DataManager = DataManager()
    
    private var listAllLocation: [LocationModel] = []
    private var mapAllLocation: [String: LocationModel] = [:]
    private var listFavoriteLocationID: [String] = []
    var updatedDataHander: (() -> Void)?
    
    override init() {
        super.init()
        weak var weakSelf = self
        DispatchQueue.global(qos: .background).async {
            do {
                if let bundlePath = Bundle.main.path(forResource: "city.list", ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let json = try JSON(data: jsonData)

                    var _list: [LocationModel] = []
                    var _map: [String: LocationModel] = [:]

                    for sub in json.arrayValue {
                        let item = LocationModel(json: sub)
                        _list.append(item)
                        _map[item.id] = item
                    }

                    DispatchQueue.main.async {
                        weakSelf?.listAllLocation = _list
                        weakSelf?.mapAllLocation = _map
                        
                        let userDefault = UserDefaults.standard

                        if let data = userDefault.value(forKey: "listFavoriteLocationID") as? [String] {
                            weakSelf?.listFavoriteLocationID = data
                        }
                        
                        weakSelf?.updatedDataHander?()
                        weakSelf?.updatedDataHander = nil
                    }
                }

            } catch {
                
            }
        }
    }
    
    func isInFavorite(_ item: LocationModel) -> Bool {
        let result = listFavoriteLocationID.filter { (id: String) in
            return item.id == id
        }
        
        return !result.isEmpty
    }
    
    func doAddLocationToFavorite(_ item: LocationModel) {
        let result = listFavoriteLocationID.filter { (id: String) in
            return item.id == id
        }
        
        if result.count == 0 {
            listFavoriteLocationID.append(item.id)
            saveData()
        }
    }
    
    func doRemoveLocationFromFavorite(_ item: LocationModel) {
        listFavoriteLocationID.removeAll { (id: String) in
            return item.id == id
        }
        
        saveData()
    }
    
    func getListLocationFavorite() -> [LocationModel] {
        var list: [LocationModel] = []
        for id in listFavoriteLocationID {
            if let item = mapAllLocation[id] {
                list.append(item)
            }
        }
        
        return list
    }
    
    func getLocationWithId(_ id: String) -> LocationModel? {
        return mapAllLocation[id]
    }
    
    private func saveData() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(listFavoriteLocationID, forKey: "listFavoriteLocationID")
        userDefault.synchronize() 
    }
    
    func doSearchLocation(name: String, complete: ((_ result: [LocationModel]) -> Void)?) {
        if listAllLocation.isEmpty {
            weak var weakSelf = self
            DispatchQueue.global(qos: .background).async {
                do {
                    if let bundlePath = Bundle.main.path(forResource: "city.list", ofType: "json"),
                        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                        let json = try JSON(data: jsonData)
                        
                        var _list: [LocationModel] = []
                        var _map: [String: LocationModel] = [:]
                        
                        for sub in json.arrayValue {
                            let item = LocationModel(json: sub)
                            _list.append(item)
                            _map[item.id] = item
                        }
                        
                        weakSelf?.listAllLocation = _list
                        weakSelf?.mapAllLocation = _map
                        
                        let searchStr = name.searchString
                        
                        let result = _list.filter { (item: LocationModel) in
                            let isExit = item.searchStr.contains(searchStr)
                            return isExit
                        }
                        
                        DispatchQueue.main.async {
                            complete?(result)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        complete?([])
                    }
                }
            }
            
        } else {
            weak var weakSelf = self
            DispatchQueue.global(qos: .background).async {
                if let strong = weakSelf {
                    let searchStr = name.searchString
                    
                    let result = strong.listAllLocation.filter { (item: LocationModel) in
                        let isExit = item.searchStr.contains(searchStr)
                        return isExit
                    }
                    
                    DispatchQueue.main.async {
                        complete?(result)
                    }
                }
            }
        }
    }
}
