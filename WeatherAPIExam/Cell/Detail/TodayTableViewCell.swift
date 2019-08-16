//
//  TodayTableViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class TodayTableViewCell: BaseTableViewCell {

    @IBOutlet weak var summaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TodayTableViewCell{
    func setSummary(currentTemperature: Double?, currentSummary: String?, temperatureHigh: Double?){
        self.summaryLabel.text = SummaryrHelper.createSummary(currentTemperature: currentTemperature, currentSummary: currentSummary, temperatureHigh: temperatureHigh)
    }
}
