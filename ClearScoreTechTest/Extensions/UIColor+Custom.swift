//
//  UIColor+Custom.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation
import UIKit

extension UIColor {
    static var lineColor = {
        return UIColor(dynamicProvider: { traitCollection in
            traitCollection.userInterfaceStyle == .light ? .black : .white
        })
    }()
}
