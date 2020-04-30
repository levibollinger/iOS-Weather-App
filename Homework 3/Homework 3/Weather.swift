//
//  Weather.swift
//  inClass8
//
//  Created by Bollinger, Levi on 11/4/19.
//  Copyright © 2019 Bollinger, Levi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Weather{
    
    var temp: Double?
    var tempMax: Double?
    var tempMin: Double?
    var desc: String?
    var humidity: Int?
    var cloudiness: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var date: String?
    var icID: String?
    
    init(json:JSON){
        let main = json["main"]
        let dt = json["dt_txt"]
        let weath = json["weather"].arrayValue
        let wind = json["wind"]
        let clouds = json["clouds"]
        let all = clouds["all"].intValue
        
        self.temp = main["temp"].doubleValue
        self.tempMax = main["temp_max"].doubleValue
        self.tempMin = main["temp_min"].doubleValue
        self.desc = weath[0]["description"].stringValue
        self.humidity = main["humidity"].intValue
        self.windSpeed = wind["speed"].doubleValue
        self.windDeg = wind["deg"].intValue
        self.cloudiness = all
        self.date = dt.stringValue
        self.icID = weath[0]["icon"].stringValue
    }
}
