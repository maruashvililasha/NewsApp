//
//  ViewController.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit
import Core
import ProgressHUD

class NewsViewController: NViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var featuredNews: Article? {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    var news : [Article] = [] {
        didSet {
            newsTableView.reloadData()
        }
    }

    var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        ProgressHUD.show()
        viewModel.getData()
    }
    
    private func setupUI() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    private func bind() {
        viewModel.loadingFinished.bind { success in
            ProgressHUD.dismiss()
        }
        viewModel.error.bind { error in
            guard let err = error, err.errorType == .toBeShown else {
                return
            }
            ProgressHUD.showError(err.errorMessage)
        }
        viewModel.featuredNews.bind { [weak self] featuredArticle in
            print("Received Featured News")
            self?.featuredNews = featuredArticle
        }
        viewModel.news.bind { [weak self] news in
            print("Received News")
            self?.news = news
        }
    }
}

extension NewsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.featuredNews != nil {
            return news.count + 1
        } else {
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let featuredNews = featuredNews {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedNeswTableViewCell") as? FeaturedNeswTableViewCell else {
                    fatalError()
                }
                cell.configure(with: featuredNews)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
                    fatalError()
                }
                let article = news[indexPath.row - 1]
                cell.configure(with: article)
                return cell
            }
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as? NewsTableViewCell else {
                fatalError()
            }
            let article = news[indexPath.row]
            cell.configure(with: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if featuredNews != nil && indexPath.row == 0  {
            return 350
        } else {
            return 200
        }
    }
}
