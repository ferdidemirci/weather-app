//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Ferdi DEMİRCİ on 15.11.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var city = String()
    
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelWeatherDec: UILabel!
    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelWeatherDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCityWeather()
        
        
    }
    
    func getCityWeather() {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=6288f40dbe91845e8dfe545f4816a3d5") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    if let inComingData = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: inComingData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(json)
                            if let main = json["main"] as? NSDictionary {
                                
                                if let temp = main["temp"] as? Double, let name = json["name"] as? String, let weather = json["weather"] as? Array<NSDictionary>{
                                    
                                    if let icon = weather.first!["icon"] as? String, let description = weather.first!["description"] as? String, let main = weather.first!["main"] as? String {
                                    
                                        
                                        let urlIcon = URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
                                            
                                            DispatchQueue.main.async {
                                                self.labelWeatherDec.text = String(Int(temp))
                                                self.labelCityName.text = name
                                                
                                                if let imageData = try? Data(contentsOf: urlIcon!) {
                                                    self.imageViewWeather.image = UIImage(data: imageData)
                                                }
                                                self.labelWeatherDescription.text = description.capitalized
                                                
                                                switch main {
                                                case "Clear":
                                                    let gradientLayer = CAGradientLayer()
                                                    gradientLayer.frame = self.view.bounds
                                                    gradientLayer.colors = [UIColor.init(red: 0, green: 0.49, blue: 1, alpha: 1).cgColor, UIColor.white.cgColor]
                                                    self.view.layer.insertSublayer(gradientLayer, at: 0)
                                                case "Clouds":
                                                    let gradientLayer = CAGradientLayer()
                                                    gradientLayer.frame = self.view.bounds
                                                    gradientLayer.colors = [UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor, UIColor.white.cgColor]
                                                    self.view.layer.insertSublayer(gradientLayer, at: 0)
                                                case "Rain":
                                                    let gradientLayer = CAGradientLayer()
                                                    gradientLayer.frame = self.view.bounds
                                                    gradientLayer.colors = [UIColor.init(red: 0.1, green: 0.2, blue: 0.6, alpha: 1).cgColor, UIColor.white.cgColor]
                                                    self.view.layer.insertSublayer(gradientLayer, at: 0)
                                                case "Snow":
                                                    let gradientLayer = CAGradientLayer()
                                                    gradientLayer.frame = self.view.bounds
                                                    gradientLayer.colors = [UIColor.init(red: 0, green: 0.49, blue: 1, alpha: 1).cgColor, UIColor.white.cgColor]
                                                    self.view.layer.insertSublayer(gradientLayer, at: 0)
                                                case "Haze":
                                                    let gradientLayer = CAGradientLayer()
                                                    gradientLayer.frame = self.view.bounds
                                                    gradientLayer.colors = [UIColor.init(red: 0.9, green: 0.87, blue: 0.77, alpha: 1).cgColor, UIColor.white.cgColor]
                                                    self.view.layer.insertSublayer(gradientLayer, at: 0)
                                                default:
                                                    self.view.backgroundColor = .white
                                                }
                                            }
                                        }
                                    }
                                }
                        } catch {
                            print("Bir json hatası mevcut.")
                        }
                    }
                }
            }.resume()
        }
            
    }

}
