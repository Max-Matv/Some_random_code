//
//  Bartender.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 31.Mar.22.
//

import Foundation


class Bartender {
    
    static let shared = Bartender()
    private var bar = Bar(allBeer: [], proceeds: 0)
    
    private init() {}
    
    func addBeer(_ beer: Beer) {
        self.bar.allBeer.append(beer)
    }
    
    func getBeer() -> [Beer] {
        self.bar.allBeer
    }
    
    func sellBeer(count: Int, index: Int) {
        self.bar.allBeer[index].count -= count
    }
    
    func putTheProceeds(cost: Int, count:Int) {
        if count != 0 {
            self.bar.proceeds += cost * count
        } 
    }
    func getTheProceeds() -> Int {
        self.bar.proceeds
    }
    func resetProceeds() {
        self.bar.proceeds = 0
    }
    func resetAll() {
        self.bar.proceeds = 0
        self.bar.allBeer.removeAll()
    }
}
