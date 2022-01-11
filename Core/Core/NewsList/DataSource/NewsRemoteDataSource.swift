//
//  MoviesRemoteDataSource.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

public protocol NewsRemoteDataSourceInterface {
    func getFeaturedNews(completion: @escaping (Result<GetNewsResponse, NError>) -> Void)
    func getNews(completion: @escaping (Result<GetNewsResponse, NError>) -> Void)
}

public class NewsRemoteDataSource: NewsRemoteDataSourceInterface {
    
    var requests = Set<NSObject>()
    
    required public init() {}
    
    public func getFeaturedNews(completion: @escaping (Result<GetNewsResponse, NError>) -> Void) {
        let path = "/v2/top-headlines"
        
        // parameters
        var params = Network.params
        params.append(URLQueryItem(name: "country", value: "us"))
        
        let manager = NetworkManager<GetNewsResponse>.shared
        manager.sendRequest(path: path, requestMethod: .get, params: params) { [weak self] error in
            completion(.failure(error))
            self?.requests.remove(manager)
        } response: { [weak self] response in
            completion(.success(response))
            guard response.status != "error" else {
                completion(.failure(NError(errorType: .toBeShown, errorMessage: response.message ?? "Server Error", endpoint: path)))
                self?.requests.remove(manager)
                return
            }
            self?.requests.remove(manager)
        }
        self.requests.insert(manager)
    }
    
    public func getNews(completion: @escaping (Result<GetNewsResponse, NError>) -> Void) {
        let path = "/v2/everything"
        
        // parameters
        var params = Network.params
        params.append(URLQueryItem(name: "domains", value: "techcrunch.com"))
        params.append(URLQueryItem(name: "sortBy", value: "popularity"))
        
        let manager = NetworkManager<GetNewsResponse>.shared
        manager.sendRequest(path: path, requestMethod: .get, params: params) { [weak self] error in
            completion(.failure(error))
            self?.requests.remove(manager)
        } response: { [weak self] response in
            guard response.status != "error" else {
                completion(.failure(NError(errorType: .toBeShown, errorMessage: response.message ?? "Server Error", endpoint: path)))
                self?.requests.remove(manager)
                return
            }
            completion(.success(response))
            self?.requests.remove(manager)
        }
        self.requests.insert(manager)
    }
    
    
}
