//
//  CoordinatesSingleton.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class CoordinatesHelper {
    private init() {}
    
    static let shared = CoordinatesHelper()
    var latitude = 0.0
    var longitude = 0.0
    
}
