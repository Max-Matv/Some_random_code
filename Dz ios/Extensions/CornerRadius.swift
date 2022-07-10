//
//  CornerRadius.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 11.May.22.
//

import Foundation
import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
