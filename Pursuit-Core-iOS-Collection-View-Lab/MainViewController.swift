//
//  ViewController.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Jaheed Haynes on 1/14/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit
import NetworkHelper

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    func fetchCountry(searchQuery: String) {
        CountryAPIClient.getCountries(searchQuery: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("could not fetch countries with error \(appError)")
            case .success(let countries):
                self?.countries = countries
            }
        })
    }
}

