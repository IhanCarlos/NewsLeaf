//
//  DSImages.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import UIKit

public enum DSImages: String {
    case logo = "Logo"
}

public enum DSSystemImages: String {
    case backChevron = "chevron.backward"
    case magnifyglass = "magnifyingglass"
}

public extension UIImage {
    static func ds(_ image: DSImages) -> UIImage {
        return UIImage(named: image.rawValue) ?? UIImage()
    }
}

public extension UIImage {
    static func dsSystem(_ image: DSSystemImages) -> UIImage {
        return UIImage(systemName: image.rawValue) ?? UIImage()
    }
}
