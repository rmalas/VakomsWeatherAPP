//
//  HistoryViewController.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/8/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpUpHistoryButton()
        setUpTextField()
        createDatePicker()
        setUpHistoryTextField()
        setUpTopSeparatorView()
        setUpBottomSeparatorView()
        getHistoryData()
    }
    
    
    
    func getHistoryData() {
        let jsonURL = "http://history.openweathermap.org/data/2.5/history/city?q=London,UK&type=hour&start=1369728000&cnt=1&appid=dc75601c3a328075e92872fbbc36b16e"
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else  { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                //let info = Info(epsDictionary: json["main"] as! [String : Any],json: json,windDictionary: json["wind"] as! [String : Any])
                print(json)
            }
            catch {
                print(error)
            }
            }.resume()
    }
    
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Back to forecast", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let picker = UIDatePicker()
    
    func createDatePicker() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([done], animated: false)
        
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
    }
    
    let historyTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Не зміг доробити це завдання через трабл з API.Доробити його не було б не важко, якби не вилітав трабл з [cod: 401, message: Invalid API key. Please see http://openweathermap.org/faq#error401 for more info.]"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    
    @objc func donePressed() {
        let formatter = DateFormatter()
       // formatter.dateStyle = .medium
        //formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
       // formatter.timeZone = TimeZone(identifier: "UTC")
        
        textField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Press to show datePicker"
        tf.textAlignment = .center
        tf.backgroundColor = UIColor.white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let topSeparatorView: UIView = {
        let esv = UIView()
        esv.backgroundColor = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        esv.translatesAutoresizingMaskIntoConstraints = false
        return esv
    }()
    
    let bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpTopSeparatorView() {
        view.addSubview(topSeparatorView)
        
        topSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topSeparatorView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        topSeparatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setUpTextField() {
        view.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func setUpBottomSeparatorView() {
        view.addSubview(bottomSeparatorView)
        
        bottomSeparatorView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomSeparatorView.bottomAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        bottomSeparatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setUpHistoryTextField() {
        view.addSubview(historyTextView)
        historyTextView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        historyTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        historyTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        historyTextView.bottomAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
    }
    
    @objc func backButtonPressed() {
        let citiesVC = CitiesController()
        present(citiesVC, animated: true, completion: nil)
    }
    
    func setpUpHistoryButton() {
        view.addSubview(backButton)
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
}
