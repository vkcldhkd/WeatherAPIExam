//
//  UserDefaultHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation

//NSKeyedArchiver 를 사용하면 custom class 를 저장할 때 오류가 생겨서 PropertyListDecoder 사용

struct UserDefaultHelper {
    
    static func set(value: Any?, key: UserDefaultType){
        if value != nil && (value as? String ) != ""{
            LogHelper.printLog("\(key.rawValue)이 성공적으로 저장되었습니다.")
            UserDefaults.standard.set(value, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    static func get(type : UserDefaultType) -> Any? {
        return UserDefaults.standard.object(forKey: type.rawValue)
    }
    
    static func remove(type : UserDefaultType) {
        if UserDefaultHelper.get(type: type) != nil{
            UserDefaults.standard.removeObject(forKey: type.rawValue)
        }
    }
    
    
}

extension UserDefaultHelper{
    
    static func getTemperatureType() -> TemperatureType? {
        guard let typeString = UserDefaultHelper.get(type: .temperatureType) as? String,
            let type = TemperatureType(rawValue: typeString) else { return nil }
        return type
    }
    
    
    //names
    static func appendNames(name: String?){
        guard let name = name else { return }
        
        var propertyListHelper = PropertyListHelper<[String]>(type: .saveNames)
        var items: [String]{
            
            if var loadItems = propertyListHelper.decode(){
                loadItems.append(name)
                return loadItems
            }else{
                return [name]
            }
        }
        propertyListHelper.data = items
        set(value: propertyListHelper.encode(), key: .saveNames)
        
    }
    
    static func loadSavedNameItems() -> [String]?{
        return PropertyListHelper<[String]>(type: .saveNames).decode()
    }
    
    //Weather
    static func loadSavedWeatherItems() -> [WeatherModel]?{
        return PropertyListHelper<[WeatherModel]>(type: .saveData).decode()
    }
    
    
    static func appendWeatherItem(model: WeatherModel){
        var propertyListHelper = PropertyListHelper<[WeatherModel]>(type: .saveData)
        var items: [WeatherModel]{
            if var loadItems = propertyListHelper.decode(){
                loadItems.append(model)
                return loadItems
            }else{
                return [model]
            }
        }
        
        propertyListHelper.data = items
        set(value: propertyListHelper.encode(), key: .saveData)
    }
    
    static func saveWeatherData(data: [WeatherModel]){
        var propertyListHelper = PropertyListHelper<[WeatherModel]>(type: .saveData)
        propertyListHelper.data = data
        set(value: propertyListHelper.encode(), key: .saveData)
    }
}
