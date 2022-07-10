//
//  BeerCellCollectionViewCell.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import UIKit

class BeerCell: UICollectionViewCell {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    
    func setupCell(beer: Beer) {
        
        beerImage.image = UIImage(named: beer.image)
        countryLabel.text = beer.country
        brandLabel.text = beer.name
        countLabel.text = String(beer.count)
        priceLabel.text = "\(beer.price)$"
        countLabel.layer.borderWidth = 2.0
        priceLabel.layer.borderWidth = 2.0
    }
    
}
