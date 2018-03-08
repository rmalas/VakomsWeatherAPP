//
//  SearchViewController.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        setUpSearchBar()
        // Do any additional setup after loading the view.
    }
 
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            let citiesVC = CitiesController()
           // citiesVC.receivingSearchText = searchBar.text!
            CitiesController.receivingSearchText = searchBar.text!
            present(citiesVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    @objc func handleCitites() {
        let citiesController = CitiesController()
        present(citiesController, animated: true, completion: nil)
    }
    
    func setUpSearchBar() {
        view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: view.topAnchor,constant: 45).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
