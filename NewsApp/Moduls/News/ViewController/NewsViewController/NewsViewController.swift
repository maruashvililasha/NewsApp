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
    @IBOutlet weak var pageNunberLabel: UILabel!
    @IBOutlet weak var nextPageButton: UIButton!
    @IBOutlet weak var previousPageButton: UIButton!
    
    @IBOutlet weak var paginationView: UIView!
    
    var currentPage = 1 {
        didSet {
            ProgressHUD.show()
            viewModel.getData(page: currentPage)
            pageNunberLabel.text = "\(currentPage)"
        }
    }
    
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
    
    private let refreshControl = UIRefreshControl()
    var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        ProgressHUD.show()
        viewModel.getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.5) {
            self.paginationView.alpha = 1
        }
    }
    
    private func setupUI() {
        paginationView.alpha = 0
        newsTableView.refreshControl = refreshControl
        newsTableView.delegate = self
        newsTableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        previousPageButton.isEnabled = false
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        ProgressHUD.show()
        viewModel.getData()
    }
    
    private func bind() {
        viewModel.loadingFinished.bind { [weak self] success in
            self?.refreshControl.endRefreshing()
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
    
    @IBAction func nextPagebuttonDidTap(_ sender: UIButton) {
        if currentPage == 1 {
            previousPageButton.isEnabled = true
        }
        currentPage += 1
    }
    
    @IBAction func previousPagebuttonDidTap(_ sender: UIButton) {
        currentPage -= 1
        if currentPage == 1 {
            previousPageButton.isEnabled = false
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
            return 250
        } else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        var url : URL?
        if let featuredNews = featuredNews {
            if indexPath.row == 0 {
                url = URL(string: featuredNews.url)
            } else {
                let article = news[indexPath.row - 1]
                url = URL(string: article.url)
            }
        } else {
            let article = news[indexPath.row]
            url = URL(string: article.url)
        }
        guard let url = url else {
            ProgressHUD.showFailed("URL Not found")
            return
        }
        ProgressHUD.show()
        let vc = Controller.getWebViewController(with: url)
        navigationController?.pushViewController(vc, animated: true)
    }
}
