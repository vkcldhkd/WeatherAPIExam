//
//  Constants.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
struct Constants {
    
    // Dark Sky API
    static let API_PATH = "https://api.darksky.net/forecast/"
    static let API_SECRET_KEY = "e3fd6f8df76a13ebfe30b38ab33e5608"
//    static let API_OPTION = "?lang=ko&units=auto"
    static let API_OPTION = "?lang=ko"
    
    // detailItmes
    static let DETAIL_TITLES: [DetailInfoType] = [
        .sunrise,
        .sunset,
        .precipProbability,
        .humidity,
        .windSpeed,
        .apparentTemperature,
        .precipIntensity,
        .pressure,
        .visibility,
        .uvIndex
    ]
    
    static let CELISIUS = "°C"
    static let FAHRENHEIT = "°F"
}
