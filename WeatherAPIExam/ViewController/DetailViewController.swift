//
//  ViewController.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var cityLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityContainerView: UIView!
    @IBOutlet weak var citySummaryLabel: UILabel!
    
    @IBOutlet weak var temperatureContainerView: UIView!
    @IBOutlet weak var temperatureContainerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!{
        didSet{
            hourlyCollectionView.regCells(names: [
                .HOURLY_COLLECTIONVIEW_CELLL
                ])
        }
    }
    @IBOutlet weak var hourlyCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var weatherTableView: UITableView!{
        didSet{
            weatherTableView.isHidden = true
            weatherTableView.regCells(names: [
                .DAILY_TABLEVIEW_CELL,
                .TODAY_TABLEVIEW_CELL,
                .TODAY_DETAIL_TABLEVIEW_CELL
                ])
        }
    }
    
    private var model: WeatherModel?
    private var name: String?
    private var detailInfo: [DetailInfoType: String?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
         "일출",
         "일몰",
         "비 올 확률",
         "습도",
         "바람",
         "체감",
         "강수량",
         "기압",
         "가시거리",
         "자외선 지수"
         */
        
        let todayWeather = model?.daily?.data?.first
        let currently = model?.currently
        
        self.detailInfo = [:]
        
        self.detailInfo?[.sunrise] = DateHelper.getDate(time: todayWeather?.sunriseTime, isSunRise: true)
        self.detailInfo?[.sunset] = DateHelper.getDate(time: todayWeather?.sunsetTime, isSunRise: false)
        self.detailInfo?[.precipProbability] = DoubleHelper.toString(value: currently?.precipProbability, appendString: "%")
        self.detailInfo?[.humidity] = DoubleHelper.toString(value: currently?.humidity, appendString: "%")
        self.detailInfo?[.windSpeed] = DoubleHelper.toString(value: currently?.windSpeed)
        self.detailInfo?[.apparentTemperature] = DoubleHelper.toTemperatureString(value: currently?.apparentTemperature)
        self.detailInfo?[.precipIntensity] = DoubleHelper.toString(value: currently?.precipIntensity)
        self.detailInfo?[.pressure] = DoubleHelper.toString(value: currently?.pressure, appendString: "hPa")
        self.detailInfo?[.visibility] = DoubleHelper.toString(value: currently?.visibility, appendString: "km")
        self.detailInfo?[.uvIndex] = "\(currently?.uvIndex ?? 0)"
        
        
        DispatchQueue.main.async {
            if self.model != nil {
                self.weatherTableView.isHidden = false
                self.temperatureLabel.text = DoubleHelper.toTemperatureString(value: currently?.temperature)
                self.cityLabel.text = self.name
                self.citySummaryLabel.text = currently?.summary
            }
            self.weatherTableView.reloadData()
            self.hourlyCollectionView.reloadData()
        }
    }
    
}

extension DetailViewController{
    @IBAction func dismissAction(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    func setDetailView(model: WeatherModel, name: String){
        self.model = model
        self.name = name
    }
}

extension DetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        guard model != nil else { return 0 }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0,
            let daily = self.model?.daily,
            let dailyItems = daily.data else { return 1 }
        return dailyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.TODAY_TABLEVIEW_CELL.rawValue, for: indexPath) as? TodayTableViewCell,
                let model = self.model else { return TodayTableViewCell() }
            
            cell.setSummary(
                currentTemperature: model.currently?.temperature,
                currentSummary: model.currently?.summary,
                temperatureHigh: model.daily?.data?.first?.temperatureHigh
            )
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.TODAY_DETAIL_TABLEVIEW_CELL.rawValue, for: indexPath) as? TodayDetailTableViewCell,
                let dict = self.detailInfo else { return TodayDetailTableViewCell() }
            
            cell.setDetailInfo(dict: dict)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCells.DAILY_TABLEVIEW_CELL.rawValue, for: indexPath) as? DailyTableViewCell,
                let model = self.model,
                let daily = model.daily,
                let items = daily.data,
                items.count > indexPath.row else { return DailyTableViewCell() }
            cell.setDailyCell(item: items[indexPath.row])
            return cell
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(weatherTableView){
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
            if velocity < 0{
                //                LogHelper.printLog("up")
                
                if self.cityLabelTopConstraint.constant > 0 {
                    self.cityLabelTopConstraint.constant -= 5
                }
                
                if self.temperatureContainerViewHeight.constant > 0{
                    self.temperatureContainerViewHeight.constant -= scrollView.contentOffset.y
                    
                    if self.temperatureContainerViewHeight.constant <= 0 {
                        UIView.animate(withDuration: 0.3) {
                            self.temperatureContainerView.alpha = 0
                            self.temperatureContainerView.isHidden = true
                        }
                    }
                }
                
            }else if velocity > 0{
                //                LogHelper.printLog("down")
                guard self.temperatureContainerView.isHidden else { return }
                
                UIView.animate(withDuration: 0.3) {
                    self.temperatureContainerViewHeight.constant = 150
                    self.temperatureContainerView.alpha = 1
                    self.temperatureContainerView.isHidden = false
                    self.cityLabelTopConstraint.constant = 50
                }
            }
            
            view.setNeedsLayout()
        }
        
    }
    
}

extension DetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 2 ? 320 : UITableView.automaticDimension
    }
}

extension DetailViewController: UICollectionViewDelegate{
    
}

extension DetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = self.model,
            let items = model.hourly?.data else { return 0 }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseCells.HOURLY_COLLECTIONVIEW_CELLL.rawValue, for: indexPath) as? HourlyCollectionViewCell,
            let model = self.model,
            let items = model.hourly?.data,
            items.count > indexPath.row else { return HourlyCollectionViewCell() }
        cell.setHourlyCell(item: items[indexPath.row])
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
}
