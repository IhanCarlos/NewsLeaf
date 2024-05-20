//
//  Utils.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case invalidData
    case requestFailed(Error)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server."
        case .invalidData:
            return "Invalid data received from server."
        case .requestFailed(let error):
            return "Request failed with error: (error.localizedDescription)"
        case .decodingError(let error):
            return "Failed to decode data: (error.localizedDescription)"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
