//
//  TodayDetailTableViewCell.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 07/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class TodayDetailTableViewCell: BaseTableViewCell {
    
    var detailInfo: [DetailInfoType: String?]?
    @IBOutlet weak var detailCollectionView: UICollectionView!{
        didSet{
            detailCollectionView.regCells(names: [
                .DETAIL_COLLECTIONVIEW_CELL
                ]
            )
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailCollectionView.collectionViewLayout = CustomCollectionViewLayout()
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    deinit {
        guard detailCollectionView != nil else { return }
        if detailCollectionView.delegate != nil{
            detailCollectionView.delegate = nil
        }
        
        if detailCollectionView.dataSource != nil{
            detailCollectionView.dataSource = nil
        }
    }
}

extension TodayDetailTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.DETAIL_TITLES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseCells.DETAIL_COLLECTIONVIEW_CELL.rawValue, for: indexPath) as? DetailCollectionViewCell,
            let dict = self.detailInfo else { return DetailCollectionViewCell() }
        
        let type = Constants.DETAIL_TITLES[indexPath.row]
        if let content = dict[type] {
            cell.setDetail(title: type.rawValue, content: content)
        }
        
        
        return cell
    }
    
    
}

extension TodayDetailTableViewCell{
    func setDetailInfo(dict: [DetailInfoType: String?]){
        self.detailInfo = dict
        self.detailCollectionView.isHidden = false
    }
}

extension TodayDetailTableViewCell: UICollectionViewDelegate{
    
}

extension TodayDetailTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 20) / 2, height: 55)
    }
}
