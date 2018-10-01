//
//  HomeViewController.swift
//  WikiMedia
//
//  Created by Deekshitha on 29/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doInitialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func doInitialSetup() {
        setUpNavigationBar()
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        
        navigationItem.title = PageTitleConstant.wikiMedia
    }
    
    private func moveToSearchViewController() {
        guard let searchVC = SearchViewController.searchViewController() else { return }
        
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        moveToSearchViewController()
        return false
    }
}

