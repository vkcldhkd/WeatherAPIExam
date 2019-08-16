//
//  MainViewControllerFooterView.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class MainViewControllerFooterView: BaseView {
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    var type: TemperatureType?
}

extension MainViewControllerFooterView{
    @IBAction func changeTemperatureAction(_ sender: Any) {
        
        guard let type = type else { return }
        let result = type == .celsius ? TemperatureType.fahrenheit : TemperatureType.celsius
        UserDefaultHelper.set(value: result.rawValue, key: .temperatureType)
        
        UIApplication.shared.post(name: .changeTemperatureType, userInfo: nil)
    }
    
    @IBAction func addCityAction(_ sender: Any) {
        UIApplication.shared.post(
            name: .loadContainerVC,
            userInfo: nil
        )
    }
    
    func setType(type: TemperatureType?){
        self.type = type
        temperatureTypeLabel.attributedText = FontHelper.getTemperatureType(isFahrenheit: type == .fahrenheit ? true : false)
    }
}
