//
//  UICollectionView.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

extension UICollectionView{
    func regCells(names: [ReuseCells]){
        names.forEach{ [weak self] in
            self?.register(
                UINib(nibName: $0.rawValue, bundle: nil),
                forCellWithReuseIdentifier: $0.rawValue)
        }
    }
}
