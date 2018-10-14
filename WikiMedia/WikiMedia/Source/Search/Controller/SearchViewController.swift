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
    private var shouldShowKeyBoard: Bool = false
    private var searchTerm: String?
    
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
        let storyBoard = mainStoryboard()
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: SearchViewController.className()) as? SearchViewController else {
            return nil
        }
        return viewController
    }   
    
    private func doInitialSetUp() {
        setUpNavigationBar()
        setUpTableView()
        setUpPresenter()
        //show focus to the search bar on load.
        shouldShowKeyBoard = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldShowKeyBoard {
            self.perform(#selector(showKeyBoard), with: nil, afterDelay: 0.1)
        }
    }
    
    @objc private func showKeyBoard() {
        searchController?.searchBar.becomeFirstResponder()
        shouldShowKeyBoard = false
    }
    
    override func setUpNavigationBar() {
        super.setUpNavigationBar()
        setUpSearchController()
        
        // hides back button
        navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.titleView = searchController?.searchBar
        
        var image = UIImage(named: ImageNameConstant.wikiLogo)
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
    }
    
    private func setUpSearchController() {
        guard searchController == nil else { return }
        
        searchController = UISearchController(searchResultsController:  nil)
        searchController?.searchResultsUpdater = self
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = false
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
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: SearchResultTableViewCell.className(), bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.className())
    }
    
    private func loadSearchDetailView(with pageDetails: SearchResultPage) {
        guard let detailVC = SearchDetailViewController.searchDetailViewController() else { return }
        navigationController?.pushViewController(detailVC, animated: true)
        detailVC.setPageDetails(pageDetails)
    }
    
    private func showNoResultAvailableLabel() {
        let noResultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        noResultLabel.text             = MessageConstant.noSearchResult + "\"\(searchTerm ?? "")\""
        noResultLabel.textColor        = UIColor.black
        noResultLabel.textAlignment    = .center
        tableView.backgroundView = noResultLabel
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let page = presenter?.page(at: indexPath.row) else { return }
        
        loadSearchDetailView(with: page)
        searchController?.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: SearchPresenterOutput {
    func updateUI() {
        hideLoadingIndicator()
        
        let numberOfItems = presenter?.numberOfSearchResults() ?? 0
        if numberOfItems == 0 {
           showNoResultAvailableLabel()
        }
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { }
}

extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoadingIndicator(parent: self.view)
        searchTerm = searchText
        presenter?.fetchSearchResult(of: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showLoadingIndicator(parent: self.view)
        let searchText = searchBar.text
        searchTerm = searchText
        presenter?.fetchSearchResult(of: searchText)
    }
}
