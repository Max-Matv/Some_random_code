//
//  Berr.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import Foundation


class Beer {
    
    let name: String
    let country: String
    let image: String
    let background: String
    let price: Int
    var count: Int
    
    init(name: String, country: String, image: String, background: String, price: Int, count: Int) {
        self.name = name
        self.country = country
        self.image = image
        self.background = background
        self.price = price
        self.count = count
    }
    
}
