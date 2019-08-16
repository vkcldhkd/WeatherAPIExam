//
//  MapKitHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 15/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

import MapKit

struct MapKitHelper {
    static let sharedInstance = MapKitHelper()
    
    typealias SearchResponse = (MKLocalSearch.Response?, Error?)
    
    func search(
        text: String?,
        handler: @escaping (_ response: SearchResponse) -> Void
        ){
        
        let localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = text
        
        MKLocalSearch(request: localSearchRequest)
            .start { (response, error) in
                handler((response,error))
        }
    }
}
