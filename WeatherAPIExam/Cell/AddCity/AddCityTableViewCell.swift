//
//  AddCityTableViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class AddCityTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension AddCityTableViewCell{
    func setAddCityCell(name: String?){
        cityNameLabel.text = name
    }
}
