//
//  BaseCollectionViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        LogHelper.printLog("DEINIT : \(self.className)")
    }
}
