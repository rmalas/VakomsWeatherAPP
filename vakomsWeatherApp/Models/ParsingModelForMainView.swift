//
//  File.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation


struct Info {
    let temp: Double
    let name: String
    let wind: Double
    
    
    init(epsDictionary: [String : Any],json: [String:Any],windDictionary: [String : Any]) {
        self.temp = (epsDictionary["temp"] as? Double)!
        self.name = (json["name"] as? String)!
        self.wind = (windDictionary["speed"] as? Double)!
    }
}
