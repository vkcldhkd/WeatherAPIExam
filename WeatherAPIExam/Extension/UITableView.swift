//
//  UITableView.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

extension UITableView{
    func regCells(names: [ReuseCells]){
        names.forEach{ [weak self] in
            self?.register(
                UINib(nibName: $0.rawValue, bundle: nil),
                forCellReuseIdentifier: $0.rawValue
            )
        }
    }
}
