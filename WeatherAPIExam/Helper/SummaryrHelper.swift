//
//  SummerHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
struct SummaryrHelper {
    static func createSummary(currentTemperature: Double?, currentSummary: String?, temperatureHigh: Double?) -> String?{
        guard let currentTemperature = currentTemperature,
            let currentSummary = currentSummary,
            let temperatureHigh = temperatureHigh,
            let type = UserDefaultHelper.getTemperatureType() else { return nil }
        
        var temperatureTuple: (currnet: Int, high: Int){
            if type == .fahrenheit{
                return (Int(currentTemperature), Int(temperatureHigh))
            }else{
                return (DoubleHelper.toCelisius(value: currentTemperature), DoubleHelper.toCelisius(value: temperatureHigh))
            }
        }
        return "오늘: 현재날씨 \(currentSummary). 현재 기온은 \(temperatureTuple.currnet)도 이며 오늘 예상 최고 기온은 \(temperatureTuple.high)도 입니다."
    }
}
