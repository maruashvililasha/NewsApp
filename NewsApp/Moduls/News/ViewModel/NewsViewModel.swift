//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import Core

class NewsViewModel {
    var news : Box<[Bool]> = Box([])
    var featuredNews : Box<[Bool]> = Box([])
    var errorPublisher : Box<NError?> = Box(nil)

    var dataRepo: MoviesDataRepositoryInterface
    
    public init(dataRepo: MoviesDataRepository) {
        self.dataRepo = dataRepo
    }
    
}
