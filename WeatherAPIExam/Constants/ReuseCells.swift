//
//  ReuseCells.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 05/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import Foundation

enum ReuseCells: String{
    //Main
    case CITY_TABLEVIEW_CELL = "CityTableViewCell"
    case CITY_EMPTY_TABLEVIEW_CELL = "EmptyTableViewCell"
    
    //Detail
    case HOURLY_COLLECTIONVIEW_CELLL = "HourlyCollectionViewCell"
    case DAILY_TABLEVIEW_CELL = "DailyTableViewCell"
    case TODAY_TABLEVIEW_CELL = "TodayTableViewCell"
    case TODAY_DETAIL_TABLEVIEW_CELL = "TodayDetailTableViewCell"
    case DETAIL_COLLECTIONVIEW_CELL = "DetailCollectionViewCell"
    
    //Add City
    case ADD_CITY_TABLEVIEW_CELL = "AddCityTableViewCell"
}
