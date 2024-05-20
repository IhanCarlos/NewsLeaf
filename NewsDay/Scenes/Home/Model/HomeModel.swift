//
//  HomeModel.swift
//  NewsDay
//
//  Created by ihan carlos on 13/05/24.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct BannerResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [BannerArticle]
}

struct BannerArticle: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
