//
//  FlagCollectionViewCell.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Jaheed Haynes on 1/14/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit
import NetworkHelper
import DataPersistence
import ImageKit

class FlagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    
    func configureCell(with country: Country) {
        
        countryName.text = country.name
        countryCapital.text = "Capital: \(country.capital)"
        countryPopulation.text = "Population: \(country.population.description)"
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/shiny/64.png"
        
        guard let url = URL(string: imageURL) else {
            fatalError()
        }
        
        FlagImageAPIClient.fetchImageURL(for: url) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            }
        }
    }
}
