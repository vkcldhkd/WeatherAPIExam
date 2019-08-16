//
//  DetailInfoType.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation

enum DetailInfoType: String{
    case sunset = "일몰"
    case sunrise = "일출"
    case precipProbability = "비 올 확률"
    case humidity = "습도"
    case windSpeed = "바람"
    case apparentTemperature = "체감" //(high - low)
    case precipIntensity = "강수량"
    case pressure = "기압"
    case visibility = "가시거리"
    case uvIndex = "자외선 지수"
}

