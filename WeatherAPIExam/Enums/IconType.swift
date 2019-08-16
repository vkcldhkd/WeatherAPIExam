//
//  Icon.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//
import UIKit

enum IconType: String, Codable{
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case tornado = "tornado"
}

extension IconType{
    func getImage() -> UIImage?{
        switch self {
        case .clearDay: return UIImage(named: "CLEAR_DAY")
        case .clearNight: return UIImage(named: "CLEAR_NIGHT")
        case .rain: return UIImage(named: "RAIN")
        case .snow: return UIImage(named: "SNOW")
        case .sleet: return UIImage(named: "SLEET")
        case .wind: return UIImage(named: "WIND")
        case .fog: return UIImage(named: "FOG")
        case .cloudy: return UIImage(named: "CLOUDY")
        case .partlyCloudyDay: return UIImage(named: "PARTLY_CLOUDY_DAY")
        case .partlyCloudyNight: return UIImage(named: "PARTLY_CLOUDY_NIGHT")
        case .hail: return UIImage(named: "HAIL")
        case .thunderstorm: return UIImage(named: "THUNDERSTORM")
        case .tornado: return UIImage(named: "TORNADO")
        }
    }
}
