//
//  ViewController.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facade()
    }
    
    func facade() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        view.addSubview(mainImageView)
        setpUpMainImage()
        setUpTempLabel()
        setUpWindLabel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(performSearch))
    }
    
    @objc func performSearch() {
        let searchController = SearchViewController()
        present(searchController, animated: true, completion: nil)
        
    }
    
    var positionTemp = 0.0
    var locationCity = ""
    var wind = 0.0
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.text = "UpdatingTempForLocation"
        return label
    }()
    
    let windLabel:UILabel = {
        let label = UILabel()
        label.text = "UpdatingWindSpeedForLocation"
        return label
    }()
    
    
    let mainImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = UIImage(named: "image.png")
        theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return theImageView
    }()
    
    func setUpTempLabel() {
        tempLabel.frame = CGRect(x: 100, y: 300, width: 180, height: 200)
        tempLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        tempLabel.sizeToFit()
        view.addSubview(tempLabel)
    }
    
    func setUpWindLabel() {
        windLabel.frame = CGRect(x: 100, y: 350, width: 180, height: 200)
        windLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        windLabel.sizeToFit()
        view.addSubview(windLabel)
    }
    
    
    
    func setpUpMainImage() {
        mainImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 28).isActive = true
    }
    
    func getData(latitude: Double,longitude: Double){
        let jsonURL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=dc75601c3a328075e92872fbbc36b16e"
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else  { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                let info = Info(epsDictionary: json["main"] as! [String : Any],json: json,windDictionary: json["wind"] as! [String : Any])
                print(info)
                DispatchQueue.main.async {
                    self.navigationItem.title = info.name
                    self.tempLabel.text = "Temperature: \(info.temp)"
                    self.windLabel.text = "Wind speed is \(info.wind)m p/s"
                }
            }
            catch {
                print(error)
            }
            
            }.resume()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CoordinatesHelper.shared.latitude = (manager.location?.coordinate.latitude)!
        CoordinatesHelper.shared.longitude = (manager.location?.coordinate.longitude)!
        getData(latitude: CoordinatesHelper.shared.latitude, longitude: CoordinatesHelper.shared.longitude)
        locationManager.stopUpdatingLocation()
    }
    
}

