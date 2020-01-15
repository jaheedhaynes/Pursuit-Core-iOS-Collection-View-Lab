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
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!

    public func configureCell(with image: Country) {
        
       // let flag = image.flag
        

    }
}
