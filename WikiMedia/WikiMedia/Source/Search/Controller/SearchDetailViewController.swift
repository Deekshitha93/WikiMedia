//
//  SearchDetailViewController.swift
//  WikiMedia
//
//  Created by Deekshitha on 14/10/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit
import WebKit

class SearchDetailViewController: BaseViewController {
    
    var webView: WKWebView?
    lazy var presenter: SearchDetailPresenterInput? = SearchDetailPresenter(output: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doInitialSetUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func searchDetailViewController() -> SearchDetailViewController? {
        let storyboard = mainStoryboard()
    
        guard let viewController = storyboard.instantiateViewController(withIdentifier: SearchDetailViewController.className()) as? SearchDetailViewController else {
            return nil
        }
        return viewController
    }
    
    private func doInitialSetUp() {
        setUpNavigationBar()
        loadWebView()
        loadRequest()
    }
    
    private func loadWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.navigationDelegate = self
        view = webView
    }
    
    private func loadRequest() {
        guard let urlRequest = presenter?.getSearchDetailRequest() else { return }
        webView?.load(urlRequest)
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.title = presenter?.getPageTitle()
    }
    
    func setPageDetails(_ pageDetails: SearchResultPage) {
        presenter?.pageDetails = pageDetails
    }
}

extension SearchDetailViewController: SearchDetailPresenterOutput {

}

extension SearchDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoadingIndicator()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoadingIndicator(parent: webView)
    }
}
