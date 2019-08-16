//
//  PropertyListHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation

struct PropertyListHelper<T: Codable> {
    var data: T?
    var type: UserDefaultType
}

extension PropertyListHelper{
    init(type: UserDefaultType) {
        self.type = type
    }
    
    func encode() -> Data? {
        guard let archivedData = try? PropertyListEncoder().encode(data) else {
            LogHelper.printLog("encode 실패")
            return nil
        }
        return archivedData
    }
    
    func decode() -> T?{
        guard let saveData = UserDefaultHelper.get(type: type) as? Data,
            let archivedData = try? PropertyListDecoder().decode(T.self, from: saveData) else { return nil }
        return archivedData
    }
}
