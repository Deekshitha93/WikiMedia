//
//  SearchDetailPresenter.swift
//  WikiMedia
//
//  Created by Deekshitha on 14/10/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import UIKit

protocol SearchDetailPresenterInput: class {
    func getPageTitle() -> String
    var pageDetails: SearchResultPage? { get set }
    func getSearchDetailRequest() -> URLRequest?
}

protocol SearchDetailPresenterOutput: class {
    
}

class SearchDetailPresenter: NSObject {
    weak var presenterOutput: SearchDetailPresenterOutput?
    var pageDetails: SearchResultPage?
    
    init(output: SearchDetailPresenterOutput) {
        presenterOutput = output
    }
}

// Mark -- SearchDetailPresenterInput
extension SearchDetailPresenter: SearchDetailPresenterInput {
    func getPageTitle() -> String {
        return pageDetails?.title ?? ""
    }
    
    func getSearchDetailRequest() -> URLRequest? {
        guard let page = pageDetails else { return nil }
        guard let urlString = SearchRequestable.pageDetail(page: page).requestString() else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 0)
        return urlRequest
    }
}
