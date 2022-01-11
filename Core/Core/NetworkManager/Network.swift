//
//  Network.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

class Network {
    static let timeOutInterval : Double = 10
    // Building URL
    static var urlBuilder = URLComponents()
    static let https = "https"
    static let host = "newsapi.org"
    
    static let apiKey = "3694dad9cbc345c3b86afe90fe329cca"
    
    static let posterPath = "https://image.tmdb.org/t/p/original/"

    static var apiUrl: URLComponents {
        urlBuilder.scheme = https
        urlBuilder.host = host
        return urlBuilder
    }
    
    static var params: [URLQueryItem] {
        let params : [URLQueryItem] = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return params
    }
}
