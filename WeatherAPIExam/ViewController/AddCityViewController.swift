//
//  AddCityViewController.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit
import MapKit

class AddCityViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!{
        didSet{
            citiesTableView.regCells(names: [
                .ADD_CITY_TABLEVIEW_CELL
                ])
        }
    }
    
    private var citiesItems: [MKMapItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }
}

extension AddCityViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        LogHelper.printLog("searchText : \(searchText)")
        guard searchText.count > 0 else {
            self.removeAll()
            return
        }
        
        MapKitHelper.sharedInstance.search(text: searchText) { [weak self] in
            LogHelper.printLog("result : \( $0)")
            let response = $0.0
            let error = $0.1
            
            if let error = error {
                LogHelper.printLog("search error : \(error.localizedDescription)")
                self?.removeAll()
            }
            
            guard let resultResponse = response,
                resultResponse.mapItems.count != 0 else {
                    self?.removeAll()
                    return
            }
            
            self?.citiesItems = resultResponse.mapItems
            
            DispatchQueue.main.async {
                self?.citiesTableView.reloadData()
            }
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async { [weak self] in
            self?.searchBar.resignFirstResponder()
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func removeAll(){
        DispatchQueue.main.async { [weak self] in
            self?.citiesItems?.removeAll()
            self?.citiesTableView.reloadData()
        }
    }
}

extension AddCityViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let items = self.citiesItems,
            items.count > indexPath.row else { return }
        
        self.dismiss(animated: true) {
            UIApplication.shared.post(
                name: .appendMKMapItems,
                userInfo: [
                    .mkMapItem: items[indexPath.row]
                ]
            )
        }
    }
}

extension AddCityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.citiesItems else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.ADD_CITY_TABLEVIEW_CELL.rawValue, for: indexPath) as? AddCityTableViewCell,
            let items = self.citiesItems,
            items.count > indexPath.row else { return AddCityTableViewCell() }
        cell.setAddCityCell(name: items[indexPath.row].placemark.title)
        return cell
    }
}
