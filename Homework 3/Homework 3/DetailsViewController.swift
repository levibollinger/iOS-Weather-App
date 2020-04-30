//
//  DetailsViewController.swift
//  inClass8
//
//  Created by Bollinger, Levi on 11/4/19.
//  Copyright © 2019 Bollinger, Levi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDegree: UILabel!
    @IBOutlet weak var cloudiness: UILabel!
    @IBOutlet weak var dwImage: UIImageView!
    
    var city : String?
    var country: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = city! + ", " + country!
        
        
        let url = "http://api.openweathermap.org/data/2.5/weather"
            
        let parameters: Parameters = ["q": city! + "," + country!,"appid": "82a9dab0fb3695b3a0f58de50d2bf347", "units":"imperial"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in if response.result.isSuccess{
            print("Success")
            print(response.request!)
            
            let data = response.result.value
            
            print(data!)
            
            let weatherJson = JSON(data!)
            let weather = Weather(json: weatherJson)
            
            self.temp.text = String(weather.temp!) + "° F"
            self.maxTemp.text = String(weather.tempMax!) + "° F"
            self.minTemp.text = String(weather.tempMin!) + "° F"
            self.desc.text = weather.desc!.capitalized
            self.humidity.text = String(weather.humidity!) + "%"
            self.windSpeed.text = String(weather.windSpeed!) + " miles/hr"
            self.windDegree.text = String(weather.windDeg!) + "°"
            self.cloudiness.text = String(weather.cloudiness!) + "%"
            
            let imgUrl = URL(string: "http://openweathermap.org/img/wn/" + weather.icID! + "@2x.png")!
            let imgData = try! Data(contentsOf: imgUrl)
            let image = UIImage(data: imgData)
            self.dwImage.image = image
            }
            else{
                print("Failure")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toForecast") {
            print("toForecast")
            let forecast = segue.destination as! ForecastViewController
            forecast.country = country
            forecast.city = city
        }
    }
    
}
