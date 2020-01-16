//
//  DetailViewController.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Jaheed Haynes on 1/14/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var detailCountry: Country?
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func updateUI(){
        
        guard let country = detailCountry else {
            fatalError("cant access Country")
        }
        
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = country.population.description
        
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
        
        
        guard let url = URL(string: imageURL) else {
            showAlert(title: "OK", message: "Error, check Detail VC")
            fatalError("cant load image")
        }
        
        FlagImageAPIClient.fetchImageURL(for: url) { [weak self](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            }
        }
    }

    

}
