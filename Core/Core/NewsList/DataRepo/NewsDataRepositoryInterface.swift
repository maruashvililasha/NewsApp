//
//  MoviesDataRepositoryInterface.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

public protocol NewsDataRepositoryInterface {
    func getNews(completion: @escaping(Result<[Article], NError>) -> Void)
    func getFeaturedNews(completion: @escaping(Result<Article?, NError>) -> Void)
}
