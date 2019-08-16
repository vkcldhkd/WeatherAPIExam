//
//  ContainerPageViewController.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import UIKit

class ContainerPageViewController: UIPageViewController {
    
    var detailViewControllerArray: [UIViewController]?
    var currentPage: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        guard let index = currentPage,
            let vcArray = detailViewControllerArray,
            vcArray.count > index else { return }
        
        setViewControllers([vcArray[index]],
                           direction: .forward,
                           animated: true,
                           completion: nil
        )
        view.backgroundColor = .white
        
    }
    
    deinit {
        if delegate != nil {
            delegate = nil
        }
        
        if dataSource != nil{
            dataSource = nil
        }
    }
}

extension ContainerPageViewController{
    func setContainerPageView(data: [WeatherModel]?, names: [String]?, row: Int){
        
        guard let data = data,
            let names = names else { return }
        
        if detailViewControllerArray == nil {
            detailViewControllerArray = []
        }
        
        
        for (index, model) in data.enumerated() {
            guard let detailVC = StoryBoardType.main.instantiateViewController(withIdentifier: ReuseViewControllers.detailWeather.rawValue) as? DetailViewController,
                names.count > index else { return }
            detailVC.setDetailView(model: model, name: names[index])
            detailViewControllerArray?.append(detailVC)
        }
        currentPage = row
    }
}

extension ContainerPageViewController: UIPageViewControllerDelegate{
    
}

extension ContainerPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerArray = self.detailViewControllerArray else { return nil }
        
        var index: Int?
        for i in 0 ..< viewControllerArray.count{
            if viewControllerArray[i] == viewController {
                index = i
            }
        }
        guard let currentIndex = index else { return nil }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        guard viewControllerArray.count > previousIndex else { return nil }
        self.currentPage = previousIndex
        return viewControllerArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerArray = self.detailViewControllerArray else { return nil }
        
        var index: Int?
        for i in 0 ..< viewControllerArray.count{
            if viewControllerArray[i] == viewController {
                index = i
            }
        }
        guard let currentIndex = index else { return nil }
        
        let nextIndex = currentIndex + 1
        
        guard viewControllerArray.count != nextIndex,
            viewControllerArray.count > nextIndex else { return nil }
        self.currentPage = nextIndex
        return viewControllerArray[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        guard let vcArray = self.detailViewControllerArray else { return 0 }
        return vcArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentPage = self.currentPage else { return 0 }
        return currentPage
    }
    
}
