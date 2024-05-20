//
//  endPoint.swift
//  NewsDay
//
//  Created by ihan carlos on 16/05/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension APIEndpoint {
    var baseURL: URL? { nil }
    var headers: [String: String]? { nil }
    var parameters: [String: String]? { nil }
}
