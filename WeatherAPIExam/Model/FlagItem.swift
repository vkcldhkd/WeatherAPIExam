//
//  FlagItem.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//
import Foundation

struct FlagItem: Codable {
    let sources: [String]?
    let nearestStation: Double?
    let units: String?
    
    enum CodingKeys: String, CodingKey {
        case sources
        case nearestStation
        case units
    }
}
