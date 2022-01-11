//
//  ViewController.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit
import Core

class NewsViewController: NViewController {

    var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getData()
    }
    
    private func bind() {
        viewModel.loadingFinished.bind { success in
            print("Loading Finished", success, separator: " - ")
        }
        
        viewModel.featuredNews.bind { featuredArticle in
            print(featuredArticle)
        }
        
        viewModel.news.bind { news in
            print(news)
        }
    }
    
}

