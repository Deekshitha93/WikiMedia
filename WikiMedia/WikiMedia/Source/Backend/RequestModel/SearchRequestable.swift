//
//  SearchRequestable.swift
//  WikiMedia
//
//  Created by Deekshitha on 30/09/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation

enum SearchRequestable: ApiRequestable {
    case search(term: String)
    case pageDetail(page: SearchResultPage)
    
    var baseUrl: String? {
        switch self {
            case .search:
                 return RequestConstant.baseUrl
            case .pageDetail:
                return RequestConstant.baseUrl
        }
    }
        
    var methodName: HttpMethodName? {
        switch self  {
            case .search:
                return .get
            case .pageDetail:
                return nil
        }
    }
    
    var parameters: ApiParams? {
        switch self {
            case .search(let term):
                return getSearchTermsParameters(term: term)
            case .pageDetail(let page):
                return getPageDetailParameters(page: page)
        }
    }
    
    var headers: ApiHeaders? {
        switch self {
            case .search:
                return nil
            case .pageDetail:
                return nil
        }
    }
}

extension SearchRequestable {
    private func getSearchTermsParameters(term: String?) -> ApiParams? {
        guard let searchTerm = term else { return nil }
        var parameters = ApiParams()
        
        parameters[SearchRequestParamenterConstant.action] = SearchRequestParameterValueConstant.query
        parameters[SearchRequestParamenterConstant.format] = SearchRequestParameterValueConstant.json
        //Formatversion '2' indicates the 'JSON' response parameter
        parameters[SearchRequestParamenterConstant.formatversion] = SearchRequestParameterValueConstant.formatversion
        parameters[SearchRequestParamenterConstant.prop] = SearchRequestProp.pageImages.rawValue + "|" + SearchRequestProp.pageterms.rawValue
        parameters[SearchRequestParamenterConstant.piprop] = SearchRequestParameterValueConstant.thumbnail
        parameters[SearchRequestParamenterConstant.titles] = searchTerm
        parameters[SearchRequestParamenterConstant.generator] = SearchRequestParameterValueConstant.prefixSearch
        // 'gpsLimit' is the number of search results
        parameters[SearchRequestParamenterConstant.gpslimit] = "20"
        parameters[SearchRequestParamenterConstant.gpssearch] = searchTerm
        // 'plimit' is number of titles
        parameters[SearchRequestParamenterConstant.plimit] = "1"
        parameters[SearchRequestParamenterConstant.wbptterms] = SearchRequestParameterValueConstant.description
        
        return parameters
    }

    // Add neccessary parameters to get the page details.
    private func getPageDetailParameters(page: SearchResultPage) -> ApiParams? {
        var parameters = ApiParams()
        parameters["titles"] = page.title ?? ""
        
        return parameters
    }
}
