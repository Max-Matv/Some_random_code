//
//  UICollectionViewCell+ReuseIdentifier.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 21.Jun.22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
