//
//  GetFeaturedNewsResponse.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

//import Foundation
//
//// MARK: - GetFeaturedNewsResponce
//struct GetFeaturedNewsResponce: Codable {
//    let status: String
//    let totalResults: Int
//    let articles: [FeaturedArticle]
//}
//
//// MARK: - Article
//struct FeaturedArticle: Codable {
//    let source: FeaturedSource
//    let author, title, articleDescription: String
//    let url: String
//    let urlToImage: String?
//    let publishedAt: Date
//    let content: String?
//
//    enum CodingKeys: String, CodingKey {
//        case source, author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
//}
//
//// MARK: - Source
//struct FeaturedSource: Codable {
//    let id: String?
//    let name: String
//}
