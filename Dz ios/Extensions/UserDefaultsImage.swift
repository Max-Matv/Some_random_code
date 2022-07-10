//
//  UserDefaultsImage.swift
//  Dz ios
//
//  Created by Maksim Matveichuk on 05.Jun.22.
//

import Foundation
import UIKit

extension UserDefaults {
    func imageArray(forKey key: String) -> [UIImage]? {
        guard let array = self.array(forKey: key) as? [Data] else {
            return nil
        }
        return array.compactMap({ UIImage(data: $0) }) 
    }

    func setImages(_ imageArray: [UIImage], forKey key: String) {
        self.set(imageArray.compactMap({ $0.pngData() }), forKey: key)
    }
}
