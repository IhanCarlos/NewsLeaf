//
//  HomeEndpoint.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import Foundation

enum HomeEndpoint {
    case headlineNews
    case topHeadlines
}

extension HomeEndpoint: APIEndpoint {
    
    var path: String {
        switch self {
        case .headlineNews:
         return "everything"
        case .topHeadlines:
            return "top-headlines"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .headlineNews:
            return .get
        case .topHeadlines:
            return .get
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .headlineNews:
            return ["q": "bitcoin"]
        case .topHeadlines:
            return ["country":"us"]
        }
    }
}
