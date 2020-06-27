//
//  ViewController.swift
//  weatherApp
//
//  Created by Guest User on 17.10.2019.
//  Copyright © 2019 Guest User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weatherData: [[String:Any]] = []
    var index: Int = 0

    //MARK: Properties

    @IBOutlet weak var previousButton: UIButton!
    
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var airPressure: UITextField!

    @IBOutlet weak var humidity: UITextField!
    
    @IBOutlet weak var maxTemp: UITextField!
    
    @IBOutlet weak var minTemp: UITextField!
    
    @IBOutlet weak var temp: UITextField!
    
    @IBOutlet weak var predictability: UITextField!
    
    @IBOutlet weak var visibility: UITextField!
    
    @IBOutlet weak var windDirCompass: UITextField!
    
    @IBOutlet weak var windSpeed: UITextField!
    
    
    //MARK: Actions
    
    @IBAction func onClickNext(_ sender: Any) {
        self.displayData(self.index + 1)
        self.index = self.index + 1
    }
    
    @IBAction func onClickPrevious(_ sender: Any) {
        self.displayData(self.index - 1)
        self.index = self.index - 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.metaweather.com/api/location/44418/")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            let jsonRs = try? JSONSerialization.jsonObject(with: data, options: [])
            
            let unwrappedJsonRs = jsonRs!
            let castedJsonRs = unwrappedJsonRs as! [String:Any]
            
            let consolidatedWeatherOpt = castedJsonRs["consolidated_weather"]!
            let consolidatedWeather = consolidatedWeatherOpt as! [Any]
            
            print("\(consolidatedWeather)")
            
            DispatchQueue.main.async {
                self.initView(consolidatedWeather)
            }
            
        }
        
        task.resume()
        
    }
    
    func initView(_ data: [Any]) {
        
        let castedData = data as! [[String:Any]]
        self.weatherData = castedData
    
        self.displayData(0)
    }
    
    func displayData(_ index: Int) {
        
        if(index < self.weatherData.count && index >= 0) {
            
            let day = self.weatherData[index]
            
            self.date.text = (day["applicable_date"] as! String)
            
            self.airPressure.text = "\(day["air_pressure"] as! Double)"
            
            self.humidity.text = "\(day["humidity"] as! Int)"
            
            self.visibility.text = "\(day["visibility"] as! Double)"
            
            self.maxTemp.text = "\(day["max_temp"] as! Double)"
            self.minTemp.text = "\(day["min_temp"] as! Double)"
            self.temp.text = "\(day["the_temp"] as! Double)"
            self.predictability.text = "\(day["predictability"] as! Int)"
            self.windDirCompass.text = (day["wind_direction_compass"] as! String)
            self.windSpeed.text = "\(day["wind_speed"] as! Double)"
        }
    }


}

