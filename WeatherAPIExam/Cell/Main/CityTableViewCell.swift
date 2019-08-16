//
//  CityTableViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class CityTableViewCell: BaseTableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CityTableViewCell{
    func setCityCell(time: String?, name: String?, temperature: String?){
        timeLabel.text = time
        cityNameLabel.text = name
        temperatureLabel.text = temperature
    }
}
