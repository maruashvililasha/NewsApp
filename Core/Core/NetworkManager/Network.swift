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
    
    static let apiKey = "5a2bfda34a694d7daf2d78614dd835c8"

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
