//
//  CitiesController.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class CitiesController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    static var temp = 0.0
    
    static var receivingSearchText = String()
    
    static var itemArray = [Page]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setUpCollection()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        getDataWithCityName(city: CitiesController.receivingSearchText)
        setUpSearchButton()
        setpUpHistoryButton()
    }
    
     @objc func showHistoryPressed() {
        let dailyVC = HistoryViewController()
        //navigationController?.pushViewController(dailyVC, animated: true)
        present(dailyVC, animated: true, completion: nil)
    }
    
    var showSearch: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("search and add", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSearch() {
        let vc = SearchViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func setUpSearchButton(){
        view.addSubview(showSearch)
        //need some hieght width Constaints, X and  Y
        //is going to be placed in the center of View  and below the inputs container
        showSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showSearch.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        showSearch.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        showSearch.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    var showHistory: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Show history", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showHistoryPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func handleHistoryShow() {
        
    }
    
    func setpUpHistoryButton() {
        view.addSubview(showHistory)
        showHistory.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showHistory.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        showHistory.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        showHistory.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
  
   
    let cellId = "cellId"
    
    func setUpCollection() {
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    
    @objc func handleViewHistory() {
        let ssVC = SearchViewController()
        present(ssVC, animated: true, completion: nil)
        
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        layout.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        layout.minimumLineSpacing = 0
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    lazy var pages: [Page] = {
        return CitiesController.itemArray
    }()
    
    
    func getDataWithCityName(city: String) {
        let jsonURL = "http://api.openweathermap.org/data/2.5/weather?q=\(CitiesController.receivingSearchText)&appid=dc75601c3a328075e92872fbbc36b16e"
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else  { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                let info = Info(epsDictionary: json["main"] as! [String : Any],json: json,windDictionary: json["wind"] as! [String : Any])
                print(info)
                DispatchQueue.main.async {
                    let newPage = Page(cityName: info.name, temperature: info.temp, windSpeed: info.wind)
                    CitiesController.itemArray.append(newPage)
                    self.pages = CitiesController.itemArray
                    self.collectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
            }.resume()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
}
