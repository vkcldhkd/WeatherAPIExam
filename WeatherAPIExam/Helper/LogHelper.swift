//
//  LogHelper.swift
//  WeatherAPIExam
//
//  Created by Sung Hyun on 04/08/2019.
//  Copyright © 2019 SungHyun. All rights reserved.
//

struct LogHelper {
    static func printLog(_ err: Error) {
        #if DEBUG
        print(err)
        #else
        
        #endif
    }
    
    static func printLog(_ str : String) {
        #if DEBUG
        print(str)
        #else
        
        #endif
    }
    
    static func printLog(_ any: AnyObject) {
        #if DEBUG
        print(any)
        #else
        
        #endif
    }
    static func printLog(_ num: Int) {
        #if DEBUG
        print(num)
        #else
        
        #endif
    }
}

