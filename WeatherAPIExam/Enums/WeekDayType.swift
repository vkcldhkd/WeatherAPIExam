//
//  WeekDayType.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
enum WeekDayType: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wendseday = 4
    case thursday = 5
    case firday = 6
    case saturday = 7
}

extension WeekDayType{
    static func getDay(type: WeekDayType) -> String{
        switch type {
        case .sunday: return "일요일"
        case .monday: return "월요일"
        case .tuesday: return "화요일"
        case .wendseday: return "수요일"
        case .thursday: return "목요일"
        case .firday: return "금요일"
        case .saturday: return "토요일"
        }
    }
}
