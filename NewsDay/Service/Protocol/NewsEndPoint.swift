//
//  NewsEndPoint.swift
//  NewsDay
//
//  Created by ihan carlos on 16/05/24.
//

import Foundation

enum NewsEndpoint {
    case headlineNews
}

extension NewsEndpoint: APIEndpoint {
    
    var path: String {
        switch self {
        case .headlineNews:
          return ""
        }
    }

    var method: HTTPMethod {
        switch self {
        case .headlineNews:
            return .get
        }
    }
}
