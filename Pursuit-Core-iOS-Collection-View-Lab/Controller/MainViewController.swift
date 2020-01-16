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
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        fetchCountry(searchQuery: "t")
        
        
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

//=====================================================================================================================

//-------------------------------------------------------------------------------------
// MARK: SEARCH BAR EXTENSION

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

//-------------------------------------------------------------------------------------
// MARK: COLLECTIONVIEW DATA SOURCE EXTENSION

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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
           let interItemSpacing:CGFloat = 1
        
           let maxWidth = UIScreen.main.bounds.size.width
        
           let numberOfItems: CGFloat = 5
        
           let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
           let itemWidth:CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
           return CGSize(width: itemWidth, height: itemWidth)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
       }
      
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 1
       }
}

