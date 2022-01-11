//
//  MoviewsDataRepository.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

public class NewsDataRepository: NewsDataRepositoryInterface {
    
    let remoteDataSource : NewsRemoteDataSourceInterface
    let localDataSource : NewsLocalDataSourceInterface
    
    public init(remoteDataSource : NewsRemoteDataSourceInterface, localDataSource : NewsLocalDataSourceInterface) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource =  localDataSource
    }
    
    public func getNews(page: Int, completion: @escaping (Result<[Article], NError>) -> Void) {
        remoteDataSource.getNews(page: page, completion: { result in
            switch result {
            case .success(let response):
                guard let articles = response.articles else {
                    return
                }
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    public func getFeaturedNews(completion: @escaping (Result<Article?, NError>) -> Void) {
        remoteDataSource.getFeaturedNews { result in
            switch result {
            case .success(let response):
                guard let featuredNews = response.articles?.first else {
                    completion(.failure(NError(errorType: .couldBeRejected, errorMessage: "No Article", endpoint: nil)))
                    return
                }
                completion(.success(featuredNews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
