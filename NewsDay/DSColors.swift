//
//  DSColors.swift
//  NewsDay
//
//  Created by ihan carlos on 12/05/24.
//

import UIKit

public enum DSColors: String {
    case iceWhite = "IceWhite"
    case yellow = "Yellow"
    case purple = "SplachColor"
    case lightGray = "LightGray"
}

public extension UIColor {
    static func ds(_ color: DSColors) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
