//
//  MainViewController.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: BaseViewController {
    @IBOutlet weak var cityTableView: UITableView!{
        didSet{
            cityTableView.regCells(names: [
                .CITY_TABLEVIEW_CELL,
                .CITY_EMPTY_TABLEVIEW_CELL
                ])
        }
    }
    
    private var loadedData: [WeatherModel]?
    private var loadedNames: [String]?
    private var footerView: MainViewControllerFooterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotifications()
        loadedData = UserDefaultHelper.loadSavedWeatherItems()
        loadedNames = UserDefaultHelper.loadSavedNameItems()
        updateWeather()
    }
}

extension MainViewController: UITableViewDelegate{
    func updateWeather(){
        guard let currentData = self.loadedData else { return }
        startIndicator()
        var updateDate: [WeatherModel] = []
        
        currentData.forEach{
            guard let latitude = $0.latitude,
                let longitude = $0.longitude else { return }
            
            Networker.get(latitude: latitude, longitude: longitude) { [weak self] tuple in
                
                LogHelper.printLog("latitude : \(latitude)")
                LogHelper.printLog("longitude : \(longitude)")
                
                guard tuple.1 == nil else {
                    LogHelper.printLog("errror : \(tuple.1?.localizedDescription ?? "")")
                    self?.stopIndicator()
                    return
                }
                
                guard let model = tuple.0 else { return }
                
                updateDate.append(model)
                
                if updateDate.count == currentData.count{
                    self?.loadedData = updateDate
                    UserDefaultHelper.saveWeatherData(data: updateDate)
                    DispatchQueue.main.async {
                        LogHelper.printLog("updateWeather reloadData")
                        self?.cityTableView.reloadData()
                        self?.stopIndicator()
                    }
                }
            }
        }
    }
    
    func loadWeather(item: MKMapItem){
        let coordinate = item.placemark.coordinate
        
        Networker.get(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] tuple in
            
            guard tuple.1 == nil else {
                LogHelper.printLog("errror : \(tuple.1?.localizedDescription ?? "")")
                return
            }
            
            guard let self = self,
                let model = tuple.0 else { return }
            
            UserDefaultHelper.appendNames(name: item.name)
            UserDefaultHelper.appendWeatherItem(model: model)
            
            self.loadedData = UserDefaultHelper.loadSavedWeatherItems()
            self.loadedNames = UserDefaultHelper.loadSavedNameItems()
            
            DispatchQueue.main.async {
                self.cityTableView.reloadData()
            }
        }
    }
    
    func addNotifications(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.loadContainerVC),
            name: Notification.createName(.loadContainerVC),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.appendMKMapItems),
            name: Notification.createName(.appendMKMapItems),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refresh),
            name: Notification.createName(.changeTemperatureType),
            object: nil
        )
    }
    
    @objc func loadContainerVC(){
        DispatchQueue.main.async { [weak self] in
            guard let addCityVC = StoryBoardType.main.instantiateViewController(withIdentifier: ReuseViewControllers.addCity.rawValue) as? AddCityViewController else { return }
            
            self?.present(addCityVC, animated: true, completion: nil)
        }
    }
    
    @objc func appendMKMapItems(_ notification: Notification){
        guard let item = notification.getObjectInUserInfo(.mkMapItem) as? MKMapItem else { return }
        LogHelper.printLog("item : \(item)")
        loadWeather(item: item)
    }
    
    @objc func refresh(){
        DispatchQueue.main.async { [weak self] in
            self?.cityTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = loadedData else { return 1 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if footerView == nil {
            footerView = MainViewControllerFooterView()
        }
        footerView?.setType(type: UserDefaultHelper.getTemperatureType())
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loadedData == nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.CITY_EMPTY_TABLEVIEW_CELL.rawValue, for: indexPath) as? EmptyTableViewCell else { return EmptyTableViewCell() }
            return cell
            
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.CITY_TABLEVIEW_CELL.rawValue, for: indexPath) as? CityTableViewCell,
                let loadedData = self.loadedData,
                let loadedNames = self.loadedNames,
                loadedData.count > indexPath.row,
                loadedNames.count > indexPath.row else { return CityTableViewCell() }
            
            let weather = loadedData[indexPath.row]
            let name = loadedNames[indexPath.row]
            
            cell.setCityCell(
                time: DateHelper.getHour(time: weather.currently?.time),
                name: name,
                temperature: DoubleHelper.toTemperatureString(value: weather.currently?.temperature)
            )
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async { [weak self] in
            guard let pageVC = StoryBoardType.main.instantiateViewController(withIdentifier: ReuseViewControllers.containerPage.rawValue) as? ContainerPageViewController else { return }
            
            pageVC.setContainerPageView(
                data: self?.loadedData,
                names: self?.loadedNames,
                row: indexPath.row)
            
            self?.present(pageVC, animated: true, completion: nil)
        }
    }
}
