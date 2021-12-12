//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ferdi DEMİRCİ on 15.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldCityName: UITextField!
    @IBOutlet weak var buttonShow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        textFieldCityName.text = ""
    }
    @IBAction func buttonShowWeather(_ sender: UIButton) {
        let city = textFieldCityName.text ?? ""
        if city.isEmpty {
            
            let alert = UIAlertController(title: "Warning!", message: "You did not enter a city name", preferredStyle: .alert)
            let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(buttonCancel)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
            vc.city = city
            self.show(vc, sender: nil)
        }
    }
    
    @IBAction func buttonLocation(_ sender: Any) {
        
    }
}

