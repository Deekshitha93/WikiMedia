//
//  SearchViewController.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    private var searchController: UISearchController?
    private var presenter: SearchPresenterInput?
    
    // IBoutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doInitialSetUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    class func searchViewController() -> SearchViewController? {
        let storyBoard = UIStoryboard.init(name: StoryBoardNameConstant.main, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: SearchViewController.className()) as? SearchViewController else {
            return nil
        }
        
        return viewController
    }
    
    private func doInitialSetUp() {
        setUpNavigationBar()
        setUpTableView()
        setUpPresenter()
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        setUpSearchController()
        
        self.navigationItem.titleView = searchController?.searchBar
    }
    
    private func setUpSearchController() {
        guard searchController == nil else { return }
        
        searchController = UISearchController(searchResultsController:  nil)
        searchController?.searchResultsUpdater = self
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        registerCells()
    }
    
    private func setUpPresenter() {
        presenter = SearchPresenter.init(output: self)
        presenter?.fetchSearchResult(of: "Albert")
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: SearchResultTableViewCell.className(), bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.className())
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfSearchResults() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let page = presenter?.page(at: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.className(), for: indexPath) as? SearchResultTableViewCell {
            cell.configure(name: page.title, description: page.terms?.descriptionString, thumbnailString: page.thumbnail?.source)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchViewController: SearchPresenterOutput {
    func updateUI() {
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchViewController: UISearchControllerDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    
}
