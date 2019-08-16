//
//  DailyTableViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class DailyTableViewCell: BaseTableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DailyTableViewCell{
    func setDailyCell(item: Daily){
        dayLabel.text = DateHelper.getDay(time: item.time)
        
        temperatureHighLabel.text = DoubleHelper.toTemperatureString(value: item.temperatureHigh)
        temperatureLowLabel.text = DoubleHelper.toTemperatureString(value: item.temperatureLow)
        iconImageView.image = item.icon?.getImage()
    }
}
