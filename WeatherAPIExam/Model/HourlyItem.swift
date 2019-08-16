//
//  HourlyItem.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
struct HourlyItem: Codable {
    let summary: String?
    let icon: IconType?
    let data: [CurrentlyItem]?
}
