//
//  Notification.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation
extension Notification{
    static func createName(_ name: NotificationType) -> Notification.Name {
        return Notification.Name(name.rawValue)
    }
    
    func getObjectInUserInfo(_ type: ParameterType) -> Any?{
        return self.userInfo?[type.rawValue]
    }
}
