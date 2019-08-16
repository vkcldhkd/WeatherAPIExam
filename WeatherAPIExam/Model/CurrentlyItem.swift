//
//  CurrentlyItem.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
struct CurrentlyItem: Codable {
    let time, nearestStormDistance, windBearing, uvIndex: Int?
    let summary: String?
    let icon: IconType?
    let precipType: PrecipType?
    let temperature, apparentTemperature, dewPoint, humidity, precipIntensity, precipProbability, pressure, windSpeed, windGust, visibility, ozone, cloudCover: Double?
}
