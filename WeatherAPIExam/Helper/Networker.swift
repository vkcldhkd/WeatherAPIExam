//
//  Networker.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//
import Foundation

struct Networker {
    static func get(latitude: Double, longitude: Double, handler: @escaping (_ response: (WeatherModel?,Error?)) -> ()) {
        
        let endpoint: String = Constants.API_PATH + Constants.API_SECRET_KEY + "/\(latitude),\(longitude)" + Constants.API_OPTION
        LogHelper.printLog("endpoint : \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            LogHelper.printLog("url error!")
            return
        }
        
        URLSession.shared.weatherModelTask(with: url) { (model, response, error) in
            guard error == nil else {
                LogHelper.printLog(error!.localizedDescription)
                handler((nil, error))
                return
            }
            
            handler((model,nil))
            
        }.resume()
    }
}
