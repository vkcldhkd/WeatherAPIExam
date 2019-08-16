//
//  DetailCollectionViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension DetailCollectionViewCell{
    func setDetail(title: String, content: String?){
        self.titleLabel.text = title
        self.contentLabel.text = content
    }
}
