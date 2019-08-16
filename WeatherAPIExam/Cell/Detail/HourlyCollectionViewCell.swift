//
//  HourlyCollectionViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension HourlyCollectionViewCell {
    func setHourlyCell(item: CurrentlyItem){
        timeLabel.text = DateHelper.getHour(time: item.time)
        temperatureLabel.text = DoubleHelper.toTemperatureString(value: item.temperature)
        weatherImageView.image = item.icon?.getImage()
    }
}
