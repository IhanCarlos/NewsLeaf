//
//  HomeService.swift
//  NewsDay
//
//  Created by ihan carlos on 18/05/24.
//

import Foundation

protocol HomeServiceProtocol {
    func fetchHedlineNews(completion: @escaping (Result<NewsResponse, APIError>) -> Void)
    func fetchTopHedlineNews(completion: @escaping (Result<BannerResponse, APIError>) -> Void)
}

class HomeService: HomeServiceProtocol {
    let apiClient = URLSessionAPIClient<HomeEndpoint>()
    
    func fetchHedlineNews(completion: @escaping (Result<NewsResponse, APIError>) -> Void) {
        return apiClient.request(.headlineNews, completion: completion)
    }
    
    func fetchTopHedlineNews(completion: @escaping (Result<BannerResponse, APIError>) -> Void) {
        return apiClient.request(.topHeadlines, completion: completion)
    }
}
