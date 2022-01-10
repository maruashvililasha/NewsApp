//
//  Controller.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import Foundation
import UIKit

class Controller {
    
    static private let appDependencyContainer = AppDependencyContainer()
    
    static func getMainNavigationController() -> UINavigationController {
        let nc = UINavigationController()
        let vc = Controller.getMovieListViewController()
        nc.setViewControllers([vc], animated: false)
        return nc
    }
    
    static func getMovieListViewController() -> MovieListViewController {
        let viewModel = appDependencyContainer.newsDependencies()
        let vc = NewsViewController.instantiateFromStoryboard()
        vc.viewModel = viewModel
        return vc
    }
    
    static func getWebViewController(with: URL) -> WebViewController {
        let vc = WebViewController.instantiateFromStoryboard()
        vc.url = URL
        return vc
    }

}
