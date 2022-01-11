//
//  WebViewController.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit
import ProgressHUD
import WebKit

class WebViewController: NViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(url: url)
        webView.load(request as URLRequest)
        webView.navigationDelegate = self
        ProgressHUD.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProgressHUD.dismiss()
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
}
