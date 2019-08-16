//
//  BaseViewController.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 10/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    var activityIndicatorView = UIActivityIndicatorView(){
        didSet{
            activityIndicatorView.style = .gray
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    deinit {
        LogHelper.printLog("DEINIT : \(self.className)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicatorView.frame = view.bounds
        view.addSubview(activityIndicatorView)
    }
}

extension BaseViewController{
    func startIndicator(){
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicatorView.startAnimating()
    }
    
    func stopIndicator(){
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicatorView.stopAnimating()
    }
}
