//
//  MoviesDataRepositoryInterface.swift
//  Core
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation

public protocol NewsDataRepositoryInterface {
    func getNews(page: Int, completion: @escaping(Result<[MovieEntity],PError>) -> Void)
}
