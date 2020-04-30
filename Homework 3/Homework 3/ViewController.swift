//
//  ViewController.swift
//  inClass8
//
//  Created by Bollinger, Levi on 11/4/19.
//  Copyright © 2019 Bollinger, Levi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
    }
    
    var objArr = [Objects]()
    var keyArr = Array(AppData.cities.keys)
    var currIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (key, value) in AppData.cities {
            print("\(key) -> \(value)")
            objArr.append(Objects(sectionName: key, sectionObjects: value))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objArr[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = objArr[indexPath.section].sectionObjects[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keyArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return objArr[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currIndex = indexPath.section
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetails") {
            print("test")
            let details = segue.destination as! DetailsViewController
            print(keyArr[(tableView.indexPathForSelectedRow?.section)!])
            let country = keyArr[(tableView.indexPathForSelectedRow?.section)!]
            details.country = country
            details.city = AppData.cities[country]![(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
}
