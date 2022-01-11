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
    
    public func getNews(completion: @escaping (Result<[Article], NError>) -> Void) {
        remoteDataSource.getNews { result in
            switch result {
            case .success(let response):
                completion(.success(response.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getFeaturedNews(completion: @escaping (Result<Article?, NError>) -> Void) {
        remoteDataSource.getFeaturedNews { result in
            switch result {
            case .success(let response):
                guard let featuredNews = response.articles.first else {
                    completion(.failure(NError(errorType: .couldBeRejected, errorMessage: "No Article", endpoint: nil)))
                    return
                }
                completion(.success(featuredNews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
//    public func getNews(page: Int, completion: @escaping (Result<[MovieEntity], NError>) -> Void) {
//        localDataSource.getPage(page: page) {[weak self] localResult in
//            switch localResult {
//            case .success(let pageEntity):
//                if let pageEntity = pageEntity, pageEntity.isListValid(), let movies = pageEntity.moviesArray {
//                    completion(.success(movies))
//                } else {
//                    self?.fetchMoviesAndSave(page: page) { result in
//                        switch result {
//                        case .success(let success):
//                            guard success else {return}
//                            self?.getPopularMovies(page: page, completion: completion)
//                        case.failure(let error):
//                            if error.errorCode == -1009 {
//                                guard let movies = pageEntity?.moviesArray else {
//                                    var errorMessage: String
//                                    if page == 1 {
//                                        errorMessage = "Local Database is empty, please connect to the internet to fetch data"
//                                    } else {
//                                       errorMessage = "Please connect to the internet for more movies"
//                                    }
//                                    var error = NError(errorType: .toBeShown, errorMessage: errorMessage)
//                                    error.errorCode = -1009
//                                    completion(.failure(error))
//                                    return
//                                }
//                                completion(.success(movies))
//                            }
//                            completion(.failure(error))
//                        }
//                    }
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
//    private func fetchMoviesAndSave(page: Int, completion: @escaping(Result<Bool, NError>) -> Void) {
//        remoteDataSource.getPopularMovies(page: page) { [weak self] fetchResult in
//            switch fetchResult {
//            case .success(let page):
//                self?.localDataSource.savePage(page: page, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}
