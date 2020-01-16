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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  let detailVC = segue.destination as? DetailViewController,
            let cellIndexPath = collectionView.indexPath(for: (sender as! FlagCollectionViewCell))
            else {
                showAlert(title: "OK", message: "could nout segue")
                fatalError()
                
        }
        
        let country = countries[cellIndexPath.row]
        detailVC.detailCountry = country
    }
    
}

//-------------------------------------------------------------------------------------
// MARK: EXTENSIONS

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let search = searchBar.text else {
            print("error")
            
            return
        }
        
        fetchCountry(searchQuery: search)
        
    }
    
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
               
                return
            }
        }
    
}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? FlagCollectionViewCell else {
            fatalError("could not downcast")
        }
        
        let country = countries[indexPath.row]
        
        cell.configureCell(with: country)
        
        return cell
    }
    
}


