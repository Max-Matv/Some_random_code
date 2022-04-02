//
//  Bar.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import Foundation


class Bar {
    
    var allBeer: [Beer]
    var proceeds: Int
    
    init(allBeer: [Beer], proceeds: Int) {
        self.allBeer = allBeer
        self.proceeds = proceeds
    }
}
