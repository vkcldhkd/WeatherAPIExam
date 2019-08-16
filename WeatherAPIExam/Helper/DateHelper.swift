//
//  DateHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation

struct DateHelper {
    static func getDay(time: Int?) -> String? {
        guard let time = time else { return nil }
        let cal = Calendar(identifier: .gregorian)
        let now = Date(timeIntervalSince1970: TimeInterval(time))
        let comps = cal.dateComponents([.weekday], from: now)
        
        guard let weekDay = comps.weekday,
        let type = WeekDayType(rawValue: weekDay) else { return nil }
//        LogHelper.printLog("weekDay : \(weekDay)")
//        LogHelper.printLog("type : \(type)")
        return WeekDayType.getDay(type: type)
    }
    
    static func getDate(time: Int?, isSunRise: Bool) -> String?{
        guard let time = time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        let resultTime = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(time)))
        var resultString = isSunRise ? "오전 " : "오후 "
        
        let components = resultTime.components(separatedBy: ":")
        
        for i in 0 ..< components.count{
            if i == 0,
                let componentToInt =  Int(components[i]){
                
                if isSunRise{
                    resultString.append("\(components[i].replacingOccurrences(of: "0", with: "")):")
                }else{
                    resultString.append("\(componentToInt - 12):")
                }
            }else{
                resultString.append(components[i])
            }
        }

        return resultString
    }
    
    static func getHour(time: Int?) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        guard let time = time,
        let hour = Int(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(time)))) else { return nil }
        
        return hour > 12 ? "오후 \(hour - 12)시" : "오전 \(hour)시"
    }
}
