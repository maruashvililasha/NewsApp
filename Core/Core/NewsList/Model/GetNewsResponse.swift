//
//  GetNewsResponce.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

// MARK: - GetNewsResponce
public struct GetNewsResponse: Codable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}

// MARK: - Article
public struct Article: Codable {
    public let author: String?
    public let title, articleDescription: String
    public let url: String
    public let urlToImage: String
    public let publishedAt: String
    public let content: String?
    
    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
