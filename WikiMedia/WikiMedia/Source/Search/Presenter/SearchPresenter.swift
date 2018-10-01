//
//  SearchPresenter.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

protocol SearchPresenterInput: class {
    func numberOfSearchResults() -> Int
    func page(at index: Int?) -> SearchResultPage?
    func fetchSearchResult(of term: String?)
}

protocol SearchPresenterOutput: class {
    func updateUI()
}

class SearchPresenter: NSObject {
    weak var presenterOutput: SearchPresenterOutput?
    private var searchResults: [SearchResultPage]?
    
    init(output: SearchPresenterOutput) {
        self.presenterOutput = output
    }
    
    private func searchResult(of term: String?) {
        guard let searchTerm = term else { return }
        
        ApiManager().getSearchResult(of: searchTerm) { [weak self] (success, response, error) in
            if success {
                self?.searchResults = response?.query?.pages
                self?.presenterOutput?.updateUI()
            } else {
                
            }
        }
    }
}

extension SearchPresenter: SearchPresenterInput {
    func fetchSearchResult(of term: String?) {
        searchResult(of: term)
    }
    
    func numberOfSearchResults() -> Int {
        return searchResults?.count ?? 0
    }
    
    func page(at index: Int?) -> SearchResultPage? {
        guard let itemIndex = index else { return nil }
        guard let searchList = searchResults, searchList.isEmpty == false else { return nil }
        guard itemIndex >= 0, itemIndex < searchList.count else { return nil }
        
        return searchList[itemIndex]
    }
}
