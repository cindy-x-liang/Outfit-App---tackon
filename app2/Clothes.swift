//
//  Clothes.swift
//  app2
//
//  Created by Cindy Liang on 6/10/23.
//

import Foundation
import UIKit

class Clothes {
    var imageName: UIImageView
    var clothesType: String
    var isSelected: Bool

    init (imageName: UIImage, clothesTypeEntered: String) {
        self.imageName = UIImageView(image: imageName)
        self.clothesType = clothesTypeEntered
        self.isSelected = false
    }
}
