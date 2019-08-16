//
//  PrecipType.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

enum PrecipType: String, Codable {
    case rain
    case snow
    case sleet
    case clear_day = "clear-day"
}
