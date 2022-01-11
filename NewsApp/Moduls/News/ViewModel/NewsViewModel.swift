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
    }
    
    func getData(page: Int = 1) {
        getNews(page: page)
        if featuredNews.value == nil {
            getFeaturedNews()
        }
        getDataGroup.notify(queue: .main, execute: { [weak self] in
            self?.loadingFinished.accept(true)
        })
    }
    
    func getNews(page: Int) {
        getDataGroup.enter()
        dataRepo.getNews(page: page, completion: { [weak self] result in
            switch result {
            case .success(let news):
                self?.news.accept(news)
                self?.getDataGroup.leave()
            case .failure(let error):
                self?.error.accept(error)
            }
        })
    }
    
    func getFeaturedNews() {
        getDataGroup.enter()
        dataRepo.getFeaturedNews { [weak self] result in
            switch result {
            case .success(let featuredNews):
                self?.featuredNews.accept(featuredNews)
                self?.getDataGroup.leave()
            case .failure(let error):
                self?.error.accept(error)
            }
        }
    }
    
}
