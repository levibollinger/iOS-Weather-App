//
//  ForecastViewController.swift
//  Homework 3
//
//  Created by Bollinger, Levi on 11/6/19.
//  Copyright © 2019 Bollinger, Levi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    

    @IBOutlet weak var titleLabel: UILabel!
    var city: String?
    var country: String?
    var forecasts = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = city! + ", " + country!
        
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
        
        self.tableView.rowHeight = 120

        let url = "http://api.openweathermap.org/data/2.5/forecast"
        
        let parameters: Parameters = ["q": city! + "," + country!,"appid": "82a9dab0fb3695b3a0f58de50d2bf347", "units":"imperial"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: {(response) in if response.result.isSuccess{
            
            let data = JSON(response.result.value!)
            self.forecasts = data["list"].array!
            
            print("Success")
            print(response.result.value!)
            
            self.tableView.reloadData()
            
        }
        else{
            print("Failure")
            }
        })
        
    }
    
}

extension ForecastViewController: UITableViewDelegate {
    
}

extension ForecastViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        let objectJson = JSON(forecasts[indexPath.row])
        let obj = Weather(json: objectJson)

        cell.dateLabel.text = obj.date
        cell.tempLabel.text = String(round(obj.temp! * 10) / 10) + "° F"
        cell.humidityLabel.text = "Humidity: " + String(obj.humidity!)
        cell.descLabel.text = obj.desc!.capitalized
        cell.maxTemp.text = "High: " + String(round(obj.tempMax! * 10) / 10) + "° F"
        cell.minTemp.text = "Low: " + String(round(obj.tempMin! * 10) / 10) + "° F"
        
        let imgUrl = URL(string: "http://openweathermap.org/img/wn/" + obj.icID! + "@2x.png")!
        
        cell.weatherImage.af_setImage(withURL: imgUrl)
        
        return cell
    }
    
}
