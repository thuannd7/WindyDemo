//
//  HomeViewController.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SVPullToRefresh
import CoreLocation
import MGSwipeTableCell

class HomeViewController: UIViewController {

    @IBOutlet weak var tbvMain: UITableView!
    @IBOutlet var viewAddLocation: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblUpdate: UILabel!
    
    private var lastTime = Date()
    private let datamanager = DataManager.shared
    private var listFavorite: [LocationModel] = []
    private var mapDataDetail: [String: ForecastWeatherDataModel] = [:]
    
    private let service = WeatherService()
    private let locationHelper = LocationHelper()
    private var currentLocationData: LocationWeatherDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doGetCurrentLocationData()
    }
    
    //MARK:- IBACTIONS
    @IBAction func btnAddPressed(_ sender: Any) {
        let vc = SearchLocationViewController()
        
        weak var weakSelf = self
        vc.addLocationHander = { (location: LocationModel) in
            weakSelf?.doGetFavoriteData()
            weakSelf?.doGetWeatherData(location.id, location.lat, location.long)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:- METHODS
    func setupView() {
        self.title = "Windy demo"
        tbvMain.tableFooterView = viewAddLocation
        lblUpdate.text = lastTime.toStringWithFormat("HH:mm - dd MMM, YYYY")
        
        weak var weakSelf = self
        tbvMain.addPullToRefresh {
            weakSelf?.doGetCurrentLocationData()
            weakSelf?.doGetFavoriteData()
        }
        
        TProgressHub.show(self.view)
        datamanager.updatedDataHander = {() in
            weakSelf?.doGetFavoriteData()
            TProgressHub.hide(weakSelf?.view)
        }
    }
    
    func doGetCurrentLocationData() {
        weak var weakSelf = self
        locationHelper.getCurrentLocation { (location: CLLocation) in
            weakSelf?.doGetWeatherData("current", location.coordinate.latitude, location.coordinate.longitude)
            weakSelf?.service.getWeatherCurrentLocation(lat: "\(location.coordinate.latitude)",
                                                        long: "\(location.coordinate.longitude)",
                                                        complete: { (data: LocationWeatherDataModel) in
                                                            weakSelf?.currentLocationData = data
                                                            weakSelf?.tbvMain.reloadData()
                                                            weakSelf?.tbvMain.pullToRefreshView.stopAnimating()
                                                        }, failse: { (err: Error) in
                                                            TProgressHub.showError(err)
                                                        })
        } _: { (status: CLAuthorizationStatus) in
            DLog("false: \(status)")
            weakSelf?.tbvMain.pullToRefreshView.stopAnimating()
            weakSelf?.tbvMain.reloadData()
        }
    }
    
    func doRefreshView() {
        lblUpdate.text = lastTime.toStringWithFormat("HH:mm - dd MMM, YYYY")
        tbvMain.reloadData()
    }
    
    func doGetWeatherData(_ id: String, _ lat: Double, _ long: Double) {
        weak var weakSelf = self
        service.getForecastWeatherOfLocation(lat: "\(lat)", long: "\(long)") { (data: ForecastWeatherDataModel) in
            weakSelf?.mapDataDetail[id] = data
            weakSelf?.lastTime = Date()
            weakSelf?.doRefreshView()
            weakSelf?.tbvMain.pullToRefreshView.stopAnimating()
        } failse: { (err: Error?) in
            DLog("err: \(String(describing: err?.localizedDescription))")
            weakSelf?.tbvMain.pullToRefreshView.stopAnimating()
            TToast.showToastWithMessage(err?.localizedDescription)
        }
    }
    
    func doGetFavoriteData() {
        weak var weakSelf = self
        DispatchQueue.main.async {
            if let strong = weakSelf {
                strong.listFavorite = DataManager.shared.getListLocationFavorite()
                strong.doRefreshView()
                
                for item in strong.listFavorite {
                    strong.doGetWeatherData(item.id, item.lat, item.long)
                }
            }   
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (listFavorite.isEmpty ? 1 : listFavorite.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = HomeCurrenLocationTableViewCell.dequeCellWithTable(tableView)
            cell.billData(currentLocationData, mapDataDetail["current"], status: locationHelper.authorizationStatus)
            return cell
        }
        
        if listFavorite.isEmpty {
            let cell = NoDataTableViewCell.dequeCellWithTable(tableView)
            return cell
        }
        
        let location = listFavorite[indexPath.row]
        let data = mapDataDetail["\(location.id)"]
        let cell = HomeLocationTableViewCell.dequeCellWithTable(tableView)
        cell.delegate = self
        cell.billData(location, data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 220.0 : (listFavorite.isEmpty ? 300.0 : 50.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if  let data = mapDataDetail["current"] {
                let vc = LocationDetailViewController()
                vc.data = data
                vc.isCurrentLocation = true
                vc.locationName = currentLocationData?.name
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            if listFavorite.isEmpty {
                return
            }
            let vc = LocationDetailViewController()
            let location = listFavorite[indexPath.row]
            let data = mapDataDetail["\(location.id)"]
            vc.data = data
            vc.locationName = location.name
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: MGSwipeTableCellDelegate {
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        if direction == MGSwipeDirection.rightToLeft {
            weak var weakSelf = self
            let delete = MGSwipeButton(title: "Remove",
                                     icon: nil,
                                     backgroundColor: AppColor.redColor,
                                     padding: 18)
            { (item: MGSwipeTableCell) -> Bool in
                if let indexPath = weakSelf?.tbvMain.indexPath(for: cell) {
                    weakSelf?.doRemoveFavorite(indexPath)
                }
                return true
            }
            
            return [delete]
        }
        
        return []
    }
    
    func doRemoveFavorite(_ indexPath: IndexPath) {
        let location = listFavorite[indexPath.row]
        weak var weakSelf = self
        
        let alert = UIAlertController(title: "Remove \(location.name.capitalized)",
                                      message: "Do you want remove from favorite list?",
                                      preferredStyle: .alert)
        let actionRemove = UIAlertAction(title: "Remove", style: .destructive) { _ in
            if let strong = weakSelf {
                strong.datamanager.doRemoveLocationFromFavorite(location)
                strong.listFavorite = strong.datamanager.getListLocationFavorite()
                strong.tbvMain.reloadData()
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionRemove)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
}
