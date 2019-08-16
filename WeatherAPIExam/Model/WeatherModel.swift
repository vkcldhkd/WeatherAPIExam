//
//  WeatherModel.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//
import Foundation

struct WeatherModel: Codable {
    let latitude, longitude: Double?
    let timezone: String?
    let currently: CurrentlyItem?
    let hourly: HourlyItem?
    let daily: DailyItem?
    let flags: FlagItem?
    let offset: Int?
}
