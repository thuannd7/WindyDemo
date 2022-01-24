//
//  SearchLocationViewController.swift
//  WeatherDemo
//
//  Created by admin2 on 1/22/22.
//

import UIKit
import SwiftyJSON

class SearchLocationViewController: BaseViewController {

    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var tbvMain: UITableView!
    @IBOutlet weak var lblNoResult: UILabel!
    private var listResult: [LocationModel] = []
    var addLocationHander: ((_ location: LocationModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        txfSearch.becomeFirstResponder()
    }

    //MARK:- IBACIONS
    @IBAction func btnCancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- METHODS
    func setupView() {
        lblNoResult.isHidden = true
    }
    
    func doSearch(_ str: String) {
        if str.isEmpty {
            listResult = []
            tbvMain.reloadData()
            return
        }
        
        let datamanager = DataManager.shared
        weak var weakSelf = self
        datamanager.doSearchLocation(name: str) { (list: [LocationModel]) in
            weakSelf?.listResult = list
            weakSelf?.tbvMain.reloadData()
        }
    }
    
    func doAddToFavorite(_ item: LocationModel) {
        if item.isInFavorite {
            let datamanager = DataManager.shared
            datamanager.doRemoveLocationFromFavorite(item)
            tbvMain.reloadData()
            addLocationHander?(item)
        } else {
            let datamanager = DataManager.shared
            datamanager.doAddLocationToFavorite(item)
            tbvMain.reloadData()
            addLocationHander?(item)
        }
    }
    
    deinit {
        addLocationHander = nil
    }
}

extension SearchLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listResult[indexPath.row]
        let cell = LocationResultTableViewCell.dequeCellWithTable(tableView)
        cell.lblTitle.text = item.name.capitalized
        cell.accessoryType = item.isInFavorite ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = listResult[indexPath.row]
        doAddToFavorite(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchLocationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            doSearch(updatedText)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doSearch(textField.text ?? "")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doSearch(textField.text ?? "")
        return true
    }
}
