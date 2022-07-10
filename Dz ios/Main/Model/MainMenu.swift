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
            Menu(name: "calclulator📱", controller: "dzOne", background: "windowsEght"),
            Menu(name: "dz 2", controller: "dzTwo", background: "peach"),
            Menu(name: "Beer shop🍺", controller: "testPurchase", background: "beer"),
            Menu(name: "dz 4", controller: "dzFour", background: "colorLight"),
            Menu(name: "dz 5", controller: "dzFive", background: "simpleRed"),
            Menu(name: "dz 6", controller: "dzSix", background: "colorDark"),
            Menu(name: "dz 7", controller: "dzSeven", background: "beer"),
            Menu(name: "dz 8", controller: "dzEight", background: "peach"),
            Menu(name: "Gallery🏙", controller: "gallery", background: "simpleRed"),
            Menu(name: "CoocleGrom", controller: "browser", background: "windowsEght"),
            Menu(name: "Colored tableView", controller: "coloredTableView", background: "colorLight"),
            Menu(name: "Photo gallery🌄", controller: "PhotoGallery", background: "colorDark"),
            Menu(name: "Audio recoder🎤", controller: "AudioRecoder", background: "windowsEght")
        ]
    }
}
