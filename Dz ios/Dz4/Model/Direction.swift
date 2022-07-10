//
//  Direction.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 08.Apr.22.
//

import Foundation


enum Direction {
    case up
    case left
    case right
    case down
    
    func directionMessage() -> String {
        switch self {
        case .up:
           return "сверху"
        case .down:
           return "снизу"
        case .right:
           return "справа"
        case .left:
           return "слева"
        }
    }
}
