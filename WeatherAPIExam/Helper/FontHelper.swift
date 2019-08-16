//
//  FontHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit
struct FontHelper {
    static func getTemperatureType(isFahrenheit: Bool) -> NSMutableAttributedString{
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor.black,
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17),
            .foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
        ]
        
        if isFahrenheit{
            let result = NSMutableAttributedString()
            result.append(NSAttributedString(string: Constants.CELISIUS, attributes: normalAttributes))
            result.append(NSAttributedString(string: " / ", attributes: normalAttributes))
            result.append(NSAttributedString(string: Constants.FAHRENHEIT, attributes: boldAttributes))
            return result
        }else{
            let result = NSMutableAttributedString()
            result.append(NSAttributedString(string: Constants.CELISIUS, attributes: boldAttributes))
            result.append(NSAttributedString(string: " / ", attributes: normalAttributes))
            result.append(NSAttributedString(string: Constants.FAHRENHEIT, attributes: normalAttributes))
            return result
        }
    }
}
