//
//  MainMenu.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 22.Mar.22.
//

import Foundation


struct Menu {
    
    let name: String
    let controller: String
    let background: String
}

extension Menu {
    
    static func getMenuList() -> [Menu] {
        [
            Menu(name: "dz 1", controller: "dzOne", background: "windowsEght"),
            Menu(name: "dz 2", controller: "dzTwo", background: "peach"),
            Menu(name: "Beer shop🍺", controller: "testPurchase", background: "beer")
        ]
    }
}
