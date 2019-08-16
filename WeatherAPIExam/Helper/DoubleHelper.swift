//
//  DoubleHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
struct DoubleHelper {
    static func toString(value: Double?, appendString: String? = nil) -> String? {
        guard let value = value else { return nil }

        if let appendStr = appendString{
            var result = String(Int(value))
            result.append(appendStr)
            return result
        }else{
            return String(Int(value))
        }
    }
    
    static func getAvg(values: [Double?]) -> Double{
        var result: Double = 0
        values.forEach{
            guard let value = $0 else { return }
            result += value
        }
        return result / Double(values.count)
    }
    
    static func toTemperatureString(value: Double?) -> String? {
        guard let value = value,
        let isFahrenheit = UserDefaultHelper.getTemperatureType() else { return nil }
        return isFahrenheit == .fahrenheit ? "\(Int(value))" + Constants.FAHRENHEIT : "\(toCelisius(value: value))" + Constants.CELISIUS
        
    }
    
    static func toCelisius(value: Double) -> Int{
        return Int((value - 32) / 1.8)
    }
}
