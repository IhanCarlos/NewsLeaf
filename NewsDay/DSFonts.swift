//
//  DSFonts.swift
//  NewsDay
//
//  Created by ihan carlos on 11/05/24.
//

import UIKit

public enum DSFonts {
    case maven14
    case maven12
    case serifBold26
    case serifBold12
    case serifBold16
    case serifMedium12
}

public extension UIFont {
    static func dsFonts(_ font: DSFonts) -> UIFont {
        let fontDefalt: UIFont = systemFont(ofSize: 10)
        switch font {
        case.maven14:
            return UIFont(name: "MavenPro-Regular", size: 14) ?? fontDefalt
        case.maven12:
            return UIFont(name: "MavenPro-Regular", size: 12) ?? fontDefalt
        case.serifBold26:
            return UIFont(name: "SourceSerif4-Bold", size: 26) ?? fontDefalt
        case.serifBold12:
            return UIFont(name: "SourceSerif4-Bold", size: 12) ?? fontDefalt
        case.serifBold16:
            return UIFont(name: "SourceSerif4-Bold", size: 16) ?? fontDefalt
        case.serifMedium12:
            return UIFont(name: "SourceSerif4-Light", size: 12) ?? fontDefalt
        }
    }
}
