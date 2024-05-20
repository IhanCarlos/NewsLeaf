//
//  APIService.swift
//  NewsDay
//
//  Created by ihan carlos on 13/05/24.
//

import Foundation

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType, completion: @escaping (Result<T, APIError>) -> Void)
}

class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    
    private let defaultParameters: [String: String] = ["apiKey": APIConstants.ApiKey]
    private let defaultBaseURL: URL = URL(string: APIConstants.baseURL)!

    func request<T: Decodable>(_ endpoint: EndpointType, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let baseURL = endpoint.baseURL ?? defaultBaseURL
        var url = baseURL.appendingPathComponent(endpoint.path)
        
        var allParameters = endpoint.parameters ?? [:]
        defaultParameters.forEach { key, value in
            allParameters[key] = value
        }
        
        var queryItems: [URLQueryItem] = []
        allParameters.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = queryItems
            url = urlComponents.url ?? url
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let endpointHeaders = endpoint.headers {
            endpointHeaders.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        printRequest(request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            self.printResponse(response, data: data, request: request)
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
    
    private func printRequest(_ request: URLRequest) {
        print("\n🟦🟦🟦 Request 🟦🟦🟦")
        print("URL:\n\(request.url?.absoluteString ?? "N/A")\n")
        print("Method:\n\(request.httpMethod ?? "N/A")\n")
        print("Headers:\n\(request.allHTTPHeaderFields ?? [:])\n")
        if let body = request.httpBody {
            print("Body:\n\(String(data: body, encoding: .utf8) ?? "N/A")\n")
        }
        print("🟦🟦🟦 End Request 🟦🟦🟦\n")
    }
    
    private func printResponse(_ response: URLResponse?, data: Data, request: URLRequest) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("🔴🔴🔴 Invalid Response 🔴🔴🔴")
            return
        }
        
        let statusCode = httpResponse.statusCode
        let statusIcon = (200...299).contains(statusCode) ? "🟢" : "🔴"
        
        print("\n\(statusIcon) Response \(statusIcon)")
        print("URL:\n\(request.url?.absoluteString ?? "N/A")\n")
        print("Status Code:\n\(statusCode)\n")
        print("Headers:\n\(httpResponse.allHeaderFields)\n")
        print("Data:\n\(String(data: data, encoding: .utf8) ?? "N/A")\n")
        print("\(statusIcon) End Response \(statusIcon)\n")
    }
}
