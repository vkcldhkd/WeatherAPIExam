//
//  CustomCollectionViewLayout.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit
class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    private let perCount = 2
    private var layoutAttribute: UICollectionViewLayoutAttributes?
    private let cellWidth: CGFloat = (UIScreen.main.bounds.width - 20) / 2
    private let cellHeight: CGFloat = 55
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard layoutAttribute == nil else { return layoutAttribute }
        let attribute = UICollectionViewLayoutAttributes()
        let half = perCount + 1 / 2
        let row = indexPath.row % half
        let col = indexPath.row <= half ? 0 : 1
        
        attribute.frame = CGRect(
            x: cellWidth * CGFloat(col),
            y: cellHeight * CGFloat(row),
            width: cellWidth,
            height: cellHeight
        )
        layoutAttribute = attribute
        
        return layoutAttribute
    }
}
