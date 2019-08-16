//
//  UIApplication.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

extension UIApplication {    
    func post(name: NotificationType, userInfo: [ParameterType: Any?]? = nil){
        var info: [String: Any] = [:]
        userInfo?.forEach{ info[$0.key.rawValue] = $0.value }
        NotificationCenter.default.post(name: Notification.Name(name.rawValue), object: nil, userInfo: info.count == 0 ? nil : info)
    }
}
