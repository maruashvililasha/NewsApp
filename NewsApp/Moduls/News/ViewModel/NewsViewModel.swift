//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import Core

class NewsViewModel {
    var news : Box<[Article]> = Box([])
    var featuredNews : Box<Article?> = Box(nil)
    var loadingFinished: Box<Bool> = Box(false)
    var error : Box<NError?> = Box(nil)
    
    private let getDataGroup = DispatchGroup()

    private let dataRepo: NewsDataRepositoryInterface
    
    public init(dataRepo: NewsDataRepositoryInterface) {
        self.dataRepo = dataRepo
        getDataGroup.notify(queue: .main, execute: { [weak self] in
            self?.loadingFinished.accept(true)
        })
    }
    
    func getData() {
        getNews()
        getFeaturedNews()
    }
    
    func getNews() {
        getDataGroup.enter()
        dataRepo.getNews { [weak self] result in
            switch result {
            case .success(let news):
                self?.news.accept(news)
            case .failure(let error):
                self?.error.accept(error)
            }
            self?.getDataGroup.leave()
        }
    }
    
    func getFeaturedNews() {
        getDataGroup.enter()
        dataRepo.getFeaturedNews { [weak self] result in
            switch result {
            case .success(let featuredNews):
                self?.featuredNews.accept(featuredNews)
            case .failure(let error):
                self?.error.accept(error)
            }
            self?.getDataGroup.leave()
        }
    }
    
}
